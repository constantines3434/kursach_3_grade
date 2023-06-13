using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для Authorization.xaml
    /// </summary>
    public partial class Authorization : Page
    {
        RandomTicketGenerator db;
        public Authorization()
        {
            InitializeComponent();
            bindcombo_Users();
            db = new RandomTicketGenerator();
        }
        //ComboBox kurs
        public List<Users> Users_list { get; set; }
        private void bindcombo_Users()
        {
            Role.Items.Add("Admin");
            Role.Items.Add("User");
            Role.SelectedIndex = 0;
        }
        /// <summary>
        /// сокрытие пароля
        /// </summary>
        private void log_in_load(object sender, EventArgs e)
        {
            textBox_password.PasswordChar = '•';
            textBox_password.MaxLength = 100;
        }
        /// <summary>
        /// авторизация пользователя
        /// </summary>
        private void But_authorization(object sender, RoutedEventArgs e)
        {
            string loginUser = textBox_login.Text;
            string roleUser = Role.Text;
            string passUser = textBox_password.Password.ToString().Encrypt();
            if ((loginUser != "") && (roleUser != "") && (passUser != ""))
            {
                if (roleUser == "Admin" || roleUser == "User") //работает Admin
                {
                    //проверка на соответствиее данных
                    if (db.Users.Any(o => (o.login_ == loginUser) && (o.password_ == passUser) && (o.role_ == roleUser)))
                    {
                        MessageBox.Show("Успешная авторизация");
                        NavigationService.Navigate(new Choice_admin(roleUser));
                    }
                    else
                    {
                        MessageBox.Show("Неправильный логин или пароль");
                    }
                }
                else
                {
                    MessageBox.Show("Неверно указана роль пользователя");
                }
            }
            else MessageBox.Show("Для продолжения заполните все поля");
        }
        /// <summary>
        /// Переход к регистрации
        /// </summary>
        private void But_registration(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Sign_up());
        }
    }
}
