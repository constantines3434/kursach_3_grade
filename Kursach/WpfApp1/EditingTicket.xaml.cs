using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для EditingTicket.xaml
    /// </summary>
    public partial class EditingTicket : Page
    {
        private Tickets _selectedTicket;
        private string roleUser;
        public EditingTicket(Tickets selectedTick, string roleUser)
        {
            InitializeComponent();
            _selectedTicket = selectedTick;
            DataContext = _selectedTicket;
            InitializationTicket();
            this.roleUser = roleUser;
            InitializeBoxes();
        }
        private void InitializationTicket()
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
        private void InitializeBoxes()
        {
            quest1Id.Text = _selectedTicket.id_quest1.ToString();
            quest2Id.Text = _selectedTicket.id_quest2.ToString();
            quest3Id.Text = _selectedTicket.id_quest3.ToString();
            komplectId.Text = _selectedTicket.nom_komplect.ToString();

        }
        private void UpdateTicket()
        {
            _selectedTicket.id_quest1 = ((Tickets)quest1Id.SelectedItem).id_quest1;
            _selectedTicket.id_quest2 = ((Tickets)quest2Id.SelectedItem).id_quest2;
            _selectedTicket.id_quest3 = ((Tickets)quest3Id.SelectedItem).id_quest3;
            _selectedTicket.nom_komplect = ((Tickets)komplectId.SelectedItem).nom_komplect;
        }
        private void But_Click_Save_Question(object sender, RoutedEventArgs e)
        {
            //if (string.IsNullOrWhiteSpace(_selectedQuestion.question))
            //{
            //    MessageBox.Show("Корректно напишите вопрос");
            //    return;
            //}
            UpdateTicket();
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
            NavigationService.Navigate(new ViewingTicketTable(roleUser));
        }
    }
}
