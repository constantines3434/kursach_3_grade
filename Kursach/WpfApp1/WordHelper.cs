using System;
using System.Collections.Generic;
using Word = Microsoft.Office.Interop.Word;
using System.IO;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using DocumentFormat.OpenXml;

namespace WpfApp1
{
    internal class WordHelper
    {
        private FileInfo fileinfo_;
        public WordHelper(string filename)
        {
            if (File.Exists(filename))
            {
                fileinfo_ = new FileInfo(filename);
            }
            else
            {
                throw new ArgumentException("File not found");
            }
        }
        /// <summary>
        /// формирование word документа
        /// </summary>
        internal bool Process(Dictionary<string, string> items, string disca, int count)
        {
            using (var doc = WordprocessingDocument.Create("FilePath", WordprocessingDocumentType.Document))
            {
                MainDocumentPart mainPart = doc.AddMainDocumentPart();
                mainPart.Document = new Document();

                Body body = mainPart.Document.AppendChild(new Body());

                Paragraph para = body.AppendChild(new Paragraph());

                Run run = para.AppendChild(new Run());

                run.AppendChild(new Text("this new text for test"));
            }
            Word.Application app = null;
            try
            {
                app = new Word.Application();
                Object file = fileinfo_.FullName;

                Object missing = Type.Missing;

                app.Documents.Open(file);

                foreach (var item in items)
                {
                    Word.Find find = app.Selection.Find;
                    find.Text = item.Key;
                    find.Replacement.Text = item.Value;
                    Object wrap = Word.WdFindWrap.wdFindContinue;
                    Object replace = Word.WdReplace.wdReplaceAll;

                    find.Execute(FindText: Type.Missing,
                        MatchCase: false,
                        MatchWholeWord: false,
                        MatchWildcards: false,
                        MatchSoundsLike: missing,
                        MatchAllWordForms: false,
                        Forward: true,
                        Wrap: wrap,
                        Format: false,
                        ReplaceWith: missing, Replace: replace
                        );
                }
                Object newFileName = Path.Combine($"C:\\Users\\Constantine\\Desktop\\Kursach-ccc309eff092336d5bdddffff706391938198d7b\\Kursach\\WpfApp1\\Tickets\\",
                     count.ToString() + "_" + disca + " Билет.docx");
                app.ActiveDocument.SaveAs2(newFileName);
                app.ActiveDocument.Close();
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                return false;
            }
            finally
            {
                if (app != null)
                {
                    app.Quit();
                }
            }
        }
    }
}
