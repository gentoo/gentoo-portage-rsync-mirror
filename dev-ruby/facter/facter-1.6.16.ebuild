# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facter/facter-1.6.16.ebuild,v 1.9 2014/05/26 05:20:27 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 jruby"
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
KEYWORDS="amd64 hppa ppc ~ppc64 sparc x86"

CDEPEND="
	>=sys-apps/net-tools-1.60_p20120127084908[old-output]
	dmi? ( sys-apps/dmidecode )
	sys-apps/lsb-release
	sys-apps/pciutils"

RDEPEND+=" ${CDEPEND}"
DEPEND+=" test? ( ${CDEPEND} )"

RUBY_PATCHES=( ${P}-ifconfig-path.patch )

ruby_add_bdepend "test? ( dev-ruby/mocha )"
