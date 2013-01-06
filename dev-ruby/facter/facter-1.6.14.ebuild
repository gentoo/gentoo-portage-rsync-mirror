# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facter/facter-1.6.14.ebuild,v 1.2 2012/12/02 18:58:29 graaff Exp $

EAPI="4"

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
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

CDEPEND="
	<sys-apps/net-tools-1.60_p20120127084908
	sys-apps/dmidecode
	sys-apps/lsb-release
	sys-apps/pciutils"

RDEPEND+=" ${CDEPEND}"
DEPEND+=" test? ( ${CDEPEND} )"

ruby_add_bdepend "test? ( dev-ruby/mocha )"
