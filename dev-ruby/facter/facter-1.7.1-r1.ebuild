# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facter/facter-1.7.1-r1.ebuild,v 1.5 2013/07/22 20:40:16 ago Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 jruby"
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
KEYWORDS="amd64 hppa ppc ~ppc64 ~sparc x86"

CDEPEND="
	sys-apps/net-tools
	sys-apps/lsb-release
	dmi? ( sys-apps/dmidecode )
	pciutils? ( sys-apps/pciutils )"

RDEPEND+=" ${CDEPEND}"
DEPEND+=" test? ( ${CDEPEND} )"

RUBY_PATCHES=( ${P}-fix-proc-self-status.patch )

ruby_add_bdepend "test? ( >=dev-ruby/mocha-0.10.5:0.10 )"

all_ruby_prepare() {
	# Provide explicit path since /sbin is not in the default PATH on
	# Gentoo.
	sed -i -e 's:arp -an:/sbin/arp -an:' lib/facter/util/ec2.rb spec/unit/util/ec2_spec.rb || die

	# Ensure the correct version of mocha is used without using bundler.
	sed -i -e '9igem "mocha", "~>0.10.5"' spec/spec_helper.rb || die
}
