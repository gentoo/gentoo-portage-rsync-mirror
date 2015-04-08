# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf-archive/autoconf-archive-2014.02.28.ebuild,v 1.2 2015/02/15 08:38:32 vapier Exp $

EAPI=5

DESCRIPTION="GNU Autoconf Macro Archive"
HOMEPAGE="http://www.gnu.org/software/autoconf-archive/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_install() {
	default
	rm -rf "${ED}/usr/share/${PN}" || die
}
