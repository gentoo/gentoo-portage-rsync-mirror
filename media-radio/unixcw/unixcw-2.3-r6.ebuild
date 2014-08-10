# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/unixcw/unixcw-2.3-r6.ebuild,v 1.7 2014/08/10 21:04:02 slyfox Exp $

EAPI=2

inherit autotools eutils multilib

DESCRIPTION="A package of programs that fit together to form a morse code tutor program"
HOMEPAGE="http://radio.linux.org.au/?sectpat=morse"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/apps/ham/morse/${P}.tgz
	qt4? (	mirror://gentoo/unixcw-2.3-qt3to4.patch.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="ncurses suid qt4"

RDEPEND="ncurses? ( sys-libs/ncurses )
	qt4? ( dev-qt/qtgui:4[qt3support] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	!<=app-misc/cw-1.0.16-r1"

src_prepare() {
	epatch "${FILESDIR}"/${P}-destdir.patch \
		"${FILESDIR}"/${P}-config.patch \
		"${FILESDIR}"/${P}-parallel-make.patch \
		"${FILESDIR}"/${P}--as-needed.patch \
		"${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-fPIC.patch \
		"${FILESDIR}"/${P}-audio.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	if use qt4 ; then
		epatch "${DISTDIR}"/${P}-qt3to4.patch.gz
	fi
	eautoreconf
}

src_configure() {
	econf --libdir=/usr/$(get_libdir) \
		$(use_enable ncurses) \
		$(use_enable qt4)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README || die "dodoc failed"
	if ! use suid ; then
		fperms 711 /usr/bin/cw || die "fperms failed"
		if use ncurses ; then
			fperms 711 /usr/bin/cwcp || die "fperms failed"
		fi
		if use qt4 ; then
			fperms 711 /usr/bin/xcwcp || die "fperms failed"
		fi
	fi
}

pkg_postinst() {
	if use suid ; then
		ewarn "You have choosen to install 'cw', 'cwcp' and 'xcwcp' setuid"
		ewarn "by setting USE=suid."
		ewarn "Be aware that this is a security risk and not recommended."
		ewarn ""
		ewarn "These files do only need root access if you want to use the"
		ewarn "PC speaker for morse sidetone output. You can alternativly"
		ewarn "drop USE=suid and use sudo."
	else
		elog "Be aware that 'cw', 'cwcp' and 'xcwcp' needs root access if"
		elog "you want to use the PC speaker for morse sidetone output."
		elog "You can call the programs via sudo for that (see 'man sudo')."
	fi
}
