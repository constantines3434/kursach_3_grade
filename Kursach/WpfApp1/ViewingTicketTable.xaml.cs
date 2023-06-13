using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для ViewingTicketTable.xaml
    /// </summary>
    public partial class ViewingTicketTable : Page
    {
        private string roleUser;
        public ViewingTicketTable(string roleUser)
        {
            InitializeComponent();
            this.roleUser = roleUser;
        }
        private void BtnEdit_Click(object sender, RoutedEventArgs e) //страница редактирования
        {
            NavigationService.Navigate(new EditingTicket((sender as Button).DataContext as Tickets, roleUser));
        }
        private void BtnAdd_Click(object sender, RoutedEventArgs e) //страница добавления
        {
            NavigationService.Navigate(new AddTicket(roleUser));
        }
        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            var ticketForRemoving = DGridTicket.SelectedItems.Cast<Tickets>().ToList();

            if (MessageBox.Show($"Вы точно хотите удалить следующие {ticketForRemoving.Count()} элементов?", "Внимание",
                MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    RandomTicketGenerator.GetContext().Tickets.RemoveRange(ticketForRemoving);
                    RandomTicketGenerator.GetContext().SaveChanges();
                    MessageBox.Show("Данные удалены");

                    DGridTicket.ItemsSource = RandomTicketGenerator.GetContext().Tickets.ToList();
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
                DGridTicket.ItemsSource = RandomTicketGenerator.GetContext().Tickets.ToList();
            }
        }
        private void Form_Ticket_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Choice_admin(roleUser));
        }
        private void NextTable(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ViewingTableData_admin(roleUser));
        }
    }
}
