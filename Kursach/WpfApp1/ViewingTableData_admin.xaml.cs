using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для ViewingTableData_admin.xaml
    /// </summary>
    public partial class ViewingTableData_admin : Page
    {
        private string roleUser;
        public ViewingTableData_admin(string role)
        {
            InitializeComponent();
            roleUser = role;
        }
        private void BtnEdit_Click(object sender, RoutedEventArgs e) //страница редактирования
        {
            NavigationService.Navigate(new EditingQuestion((sender as Button).DataContext as Questions, roleUser));
        }
        private void BtnAdd_Click(object sender, RoutedEventArgs e) //страница добавления
        {
            NavigationService.Navigate(new AddEditPAge(roleUser));
        }
        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            var questionForRemoving = DGridQuestion.SelectedItems.Cast<Questions>().ToList();

            if (MessageBox.Show($"Вы точно хотите удалить следующие {questionForRemoving.Count()} элементов?", "Внимание",
                MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    RandomTicketGenerator.GetContext().Questions.RemoveRange(questionForRemoving);
                    RandomTicketGenerator.GetContext().SaveChanges();
                    MessageBox.Show("Данные удалены");

                    DGridQuestion.ItemsSource = RandomTicketGenerator.GetContext().Questions.ToList();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }

            }
        }
        private void ViewingTable_admin_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                RandomTicketGenerator.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                DGridQuestion.ItemsSource = RandomTicketGenerator.GetContext().Questions.ToList();
            }
        }
        private void Form_Ticket_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Choice_admin(roleUser));
        }
        private void Next_Table(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ViewingDisciplineTable(roleUser));
        }
    }
}
