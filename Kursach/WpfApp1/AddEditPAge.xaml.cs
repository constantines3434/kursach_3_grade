using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для AddEditPAge.xaml
    /// </summary>
    public partial class AddEditPAge : Page
    {
        private string roleUser;
        public AddEditPAge(string roleUser)
        {
            InitializeComponent();
            Initialization();
            DataContext = GetQuestions();
            this.roleUser = roleUser;
        }
        private void Initialization()
        {
            var DisciplineList = from i in RandomTicketGenerator.GetContext().Questions.ToList()
                                 select i;
            DataContext = DisciplineList;
            Disca.ItemsSource = DisciplineList;
            Disca.SelectedValuePath = "";
            Disca.DisplayMemberPath = "id_discipline";
            Disca.SelectedIndex = 1;
        }
        private Questions GetQuestions()
        {
            return new Questions
            {
                id_discipline = Convert.ToInt32(Disca.Text),// ошибка
                question = question_textbox.Text,
                type_question = Type_question.Text,
                complexity = Complexity_question.Text
            };
        }
        private void But_Click_Save_Question(object sender, RoutedEventArgs e)
        {
            var currentQuest = GetQuestions();

            if (string.IsNullOrWhiteSpace(currentQuest.question))
            {
                MessageBox.Show("Корректно напишите вопрос");
                return;
            }
            RandomTicketGenerator.GetContext().Questions.Add(currentQuest);
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