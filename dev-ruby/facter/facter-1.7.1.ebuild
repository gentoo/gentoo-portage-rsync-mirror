# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facter/facter-1.7.1.ebuild,v 1.1 2013/05/31 08:52:05 dev-zero Exp $

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
IUSE="+dmi +pciutils"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

CDEPEND="
	sys-apps/net-tools
	sys-apps/lsb-release
	dmi? ( sys-apps/dmidecode )
	pciutils? ( sys-apps/pciutils )"

RDEPEND+=" ${CDEPEND}"
DEPEND+=" test? ( ${CDEPEND} )"

RUBY_PATCHES=( ${P}-fix-proc-self-status.patch )

ruby_add_bdepend "test? ( =dev-ruby/mocha-0.10.5 )"

ruby_all_prepare() {
	# Provide explicit path since /sbin is not in the default PATH on
	# Gentoo.
	sed -i -e 's:arp -an:/sbin/arp -an:' lib/facter/util/ec2.rb || die
}
