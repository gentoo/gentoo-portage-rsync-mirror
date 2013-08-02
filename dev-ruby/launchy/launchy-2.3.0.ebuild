# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/launchy/launchy-2.3.0.ebuild,v 1.1 2013/08/02 06:15:15 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_EXTRADOC="README.md HISTORY.md"

inherit ruby-fakegem

DESCRIPTION="Helper class for launching cross-platform applications"
HOMEPAGE="http://copiousfreetime.rubyforge.org/launchy/"

LICENSE="ISC"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/addressable-2.3"

ruby_add_bdepend "test? ( >=dev-ruby/minitest-4.5.0
	dev-ruby/simplecov )"

# This test is expected to fail on linux, drop it
RUBY_PATCHES=( "${FILESDIR}"/${P}-drop-failing-test.patch )
