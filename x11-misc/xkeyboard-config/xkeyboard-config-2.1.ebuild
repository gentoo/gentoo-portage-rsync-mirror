# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkeyboard-config/xkeyboard-config-2.1.ebuild,v 1.12 2011/07/30 02:44:37 mattst88 Exp $

EAPI=3

XORG_STATIC=no

inherit xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xkeyboard-config"

DESCRIPTION="X keyboard configuration database"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/XKeyboardConfig"
[[ ${PV} == *9999* ]] || SRC_URI="${XORG_BASE_INDIVIDUAL_URI}/data/${PN}/${P}.tar.bz2"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

LICENSE="MIT"
SLOT="0"

RDEPEND=">=x11-apps/xkbcomp-1.2.1"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	dev-perl/XML-Parser"

CONFIGURE_OPTIONS="
	--with-xkb-base=\"${EPREFIX}/usr/share/X11/xkb\"
	--enable-compat-rules
	--with-xkb-rules-symlink=xorg"

src_compile() {
	# cleanup to make sure .dir files are regenerated
	# bug #328455 c#26
	xorg-2_src_compile clean
	xorg-2_src_compile
}
