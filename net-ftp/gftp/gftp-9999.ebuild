# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gftp/gftp-9999.ebuild,v 1.3 2012/05/03 05:37:17 jdhore Exp $

EAPI="1"

inherit autotools eutils subversion

DESCRIPTION="Gnome based FTP Client"
ESVN_REPO_URI="http://svn.gnome.org/svn/${PN}/trunk"
#SRC_URI="http://www.gftp.org/${P}.tar.bz2"
HOMEPAGE="http://www.gftp.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gtk ssl"

RDEPEND="dev-libs/glib:2
		 sys-libs/ncurses
		 sys-libs/readline
		 gtk? ( x11-libs/gtk+:2 )
		 ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/intltool-0.35.5
		virtual/pkgconfig"

src_unpack() {
	subversion_src_unpack
	cd "${S}"

	# remove annoying/deprecated macros
	sed -i -e "s/^\(AC_AIX\|AC_MINIX\)//g" configure.in
	sed -i -e "s/AM_PATH_\(GLIB\|GTK\).*/AC_DEFINE(dummy, 1, [dummy])/g" configure.in

	# Switching gettext to intltool
	sed -i "s/AM_GNU_GETTEXT/IT_PROG_INTLTOOL(0.35.5)\nGETTEXT_PACKAGE=gftp\nAC_SUBST(GETTEXT_PACKAGE)\nAM_GLIB_GNU_GETTEXT/" configure.in
	sed -i "s:intl/Makefile::" configure.in
	sed -i "s:intl::g" Makefile.am
	sed -i "s:LIBINTL:INTLLIBS:g" src/{gtk,text}/Makefile.am

	intltoolize --force || die "intltoolize failed"
	AT_M4DIR="." eautoreconf
}

src_compile() {
	econf \
		$(use_enable gtk gtkport) \
		$(use_enable gtk gtk20) \
		$(use_enable ssl) \
		--enable-textport || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog* README* THANKS TODO docs/USERS-GUIDE
}
