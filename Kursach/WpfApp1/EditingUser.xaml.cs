using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для EditingUser.xaml
    /// </summary>
    public partial class EditingUser : Page
    {
        private Users _selectedUser;
        public EditingUser(Users selectedUs)
        {
            InitializeComponent();
            InitializeComponent();
            _selectedUser = selectedUs;
            role_textbox.Text = selectedUs.role_;
            DataContext = _selectedUser;
        }
        public List<Users> User_list { get; set; }
        private void UpdateQuestions()
        {
            _selectedUser.login_ = login_textbox.Text;
            _selectedUser.role_ = role_textbox.Text;
            _selectedUser.password_ = password_textbox.Text;
        }

        private void But_Click_Save_Question(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(_selectedUser.login_))
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
            NavigationService.Navigate(new VIewingUsersTable(_selectedUser.role_));
        }
    }
}
