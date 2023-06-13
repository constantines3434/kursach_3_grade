using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для EditingQuestion
    /// </summary>
    public partial class EditingQuestion : Page
    {
        private Questions _selectedQuestion;
        private string roleUser;
        public EditingQuestion(Questions selectedQuest, string roleUser)
        {
            InitializeComponent();
            _selectedQuestion = selectedQuest;

            DataContext = _selectedQuestion;
            Initialization();
            this.roleUser = roleUser;
            InitializeBoxes();
        }
        private void Initialization()
        {
            var QuestionList = from i in RandomTicketGenerator.GetContext().Questions.ToList()
                               select i;
            DataContext = QuestionList;
            Disca.ItemsSource = QuestionList;
            Disca.SelectedValuePath = "";
            Disca.DisplayMemberPath = "id_discipline";
            Disca.SelectedIndex = 0;

        }
        private void InitializeBoxes()
        {
            Disca.Text = _selectedQuestion.id_discipline.ToString();
            question_textbox.Text = _selectedQuestion.question;
            Type_question.Text = _selectedQuestion.type_question;
            Complexity_question.Text = _selectedQuestion.complexity.ToString();
        }
        private void UpdateQuestions()
        {
            _selectedQuestion.id_discipline = Convert.ToInt32(Disca.Text);
            _selectedQuestion.question = question_textbox.Text;
            _selectedQuestion.type_question = Type_question.Text;
            _selectedQuestion.complexity = Complexity_question.Text;
        }
        private void But_Click_Save_Question(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(_selectedQuestion.question))
            {
                MessageBox.Show("Корректно напишите вопрос");
                return;
            }
            UpdateQuestions();
            try
            {
                RandomTicketGenerator.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
        private void But_Click_Viewing_Table_Data(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ViewingTableData_admin(roleUser));
        }
    }
}