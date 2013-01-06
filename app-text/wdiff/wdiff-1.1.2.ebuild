# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wdiff/wdiff-1.1.2.ebuild,v 1.8 2012/09/30 16:33:20 armin76 Exp $

EAPI=4

DESCRIPTION="Create a diff disregarding formatting"
HOMEPAGE="http://www.gnu.org/software/wdiff/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="experimental test"

RDEPEND="sys-apps/diffutils
	sys-apps/less"
DEPEND="${RDEPEND}
	test? ( app-misc/screen )"

src_configure() {
	econf \
		$(use_enable experimental)
}

src_test() {
	# The test suite hangs in the '3: use pager' test
	# when an incompatible screenrc is found
	touch tests/screenrc || die
	export SYSSCREENRC=tests/screenrc SCREENRC=tests/screenrc
	default
}
