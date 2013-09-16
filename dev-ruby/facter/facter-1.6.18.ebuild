# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facter/facter-1.6.18.ebuild,v 1.1 2013/09/16 06:26:39 prometheanfire Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ree18 jruby"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_BINWRAP="facter"

inherit ruby-fakegem

DESCRIPTION="A cross-platform Ruby library for retrieving facts from operating systems"
HOMEPAGE="http://www.puppetlabs.com/puppet/related-projects/facter/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+dmi"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

CDEPEND="
	>=sys-apps/net-tools-1.60_p20120127084908
	dmi? ( sys-apps/dmidecode )
	sys-apps/lsb-release
	sys-apps/pciutils"

RDEPEND+=" ${CDEPEND}"
DEPEND+=" test? ( ${CDEPEND} )"

ruby_add_bdepend "test? ( =dev-ruby/mocha-0.10.5 )"

ruby_all_prepare() {
	# Provide explicit path since /sbin is not in the default PATH on
	# Gentoo.
	sed -i -e 's:arp -an:/sbin/arp -an:' lib/facter/util/ec2.rb || die
}
