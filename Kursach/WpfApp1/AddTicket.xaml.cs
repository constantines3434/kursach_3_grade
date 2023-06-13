using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace WpfApp1
{
    public partial class AddTicket : Page
    {
        private string roleUser;
        public AddTicket(string roleUser)
        {
            InitializeComponent();
            Initialization();
            DataContext = NewTicket();
            this.roleUser = roleUser;
        }
        private void Initialization()
        {
            var TicketList = from i in RandomTicketGenerator.GetContext().Tickets.ToList()
                             select i;
            DataContext = TicketList;
            quest1Id.ItemsSource = TicketList;
            quest1Id.SelectedValuePath = "";
            quest1Id.DisplayMemberPath = "id_quest1";
            quest1Id.SelectedIndex = 0;

            quest2Id.ItemsSource = TicketList;
            quest2Id.SelectedValuePath = "";
            quest2Id.DisplayMemberPath = "id_quest2";
            quest2Id.SelectedIndex = 0;

            quest3Id.ItemsSource = TicketList;
            quest3Id.SelectedValuePath = "";
            quest3Id.DisplayMemberPath = "id_quest3";
            quest3Id.SelectedIndex = 0;

            komplectId.ItemsSource = TicketList;
            komplectId.SelectedValuePath = "";
            komplectId.DisplayMemberPath = "nom_komplect";
            komplectId.SelectedIndex = 0;
        }
        private Tickets NewTicket() //новый билет
        {
            return new Tickets
            {
                id_quest1 = ((Tickets)quest1Id.SelectedItem).id_quest1,
                id_quest2 = ((Tickets)quest2Id.SelectedItem).id_quest2,
                id_quest3 = ((Tickets)quest3Id.SelectedItem).id_quest3,
                nom_komplect = ((Tickets)komplectId.SelectedItem).nom_komplect
            };
        }
        private void But_Click_Save_Ticket(object sender, RoutedEventArgs e)
        {
            var currentTicket = NewTicket();
            try
            {
                RandomTicketGenerator.GetContext().Tickets.Add(currentTicket);
                RandomTicketGenerator.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
        private void But_viewing_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ViewingTicketTable(roleUser));
        }
    }
}
