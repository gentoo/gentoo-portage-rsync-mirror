# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/nvram-wakeup/nvram-wakeup-0.97_p863.ebuild,v 1.6 2012/05/24 05:48:22 vapier Exp $

inherit flag-o-matic eutils

MY_P=${P%_p*}
REV=${P#*_p}
DESCRIPTION="read and write the WakeUp time in the BIOS"
HOMEPAGE="http://sourceforge.net/projects/nvram-wakeup"
SRC_URI="mirror://sourceforge/nvram-wakeup/${MY_P}.tar.bz2"
[[ -n ${REV} ]] && SRC_URI="${SRC_URI}
	http://nvram-wakeup.svn.sourceforge.net/viewvc/*checkout*/nvram-wakeup/trunk/nvram-wakeup/nvram-wakeup-mb.c?revision=${REV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="nls"
[[ -n ${REV} ]] && RESTRICT="mirror" #168114

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	if [[ -n ${REV} ]] ; then
		cp "${DISTDIR}"/nvram-wakeup-mb.c?revision=${REV} "${S}"/nvram-wakeup-mb.c || die
	fi
	cd "${S}"
	use nls || epatch "${FILESDIR}"/${MY_P}-nonls.patch
	# Need to be careful with CFLAGS since this could eat your bios
	strip-flags
	sed -i \
		-e "s:= -O2 -Wall -Wstrict-prototypes -g -mcpu=i686:+=:" \
		Makefile || die "setting CFLAGS"
}

src_install() {
	emake \
		prefix="${D}"/usr \
		MANDIR="${D}"/usr/share/man \
		DOCDIR="${D}"/usr/share/doc/${PF} \
		install || die

	dodoc "${D}"/usr/bin/vdrshutdown
	rm -f "${D}"/usr/bin/vdrshutdown
	dodoc set_timer

	rm -f "${D}"/usr/sbin/time
	rm -f "${D}"/usr/share/man/man*/time.8*

	prepalldocs
}

pkg_postinst() {
	echo
	ewarn "WARNING:"
	ewarn "This program  writes into the  NVRAM  (used by  BIOS to store the CMOS"
	ewarn "settings).  This is  DANGEROUS.  Do it at  your own  risk.  Neither the"
	ewarn "author  of  this program  (nvram-wakeup)  nor anyone else  can be made"
	ewarn "responsible to any damage made by this program in any way."
	ewarn "(The worst case  happened to me is that on reboot the BIOS noticed the"
	ewarn "illegal  contents of  the nvram and  set everything to default values."
	ewarn "But this doesn't mean that you can't destroy even your whole computer.)"
	echo
	ewarn "		YOU HAVE BEEN WARNED, HAVE A NICE DAY"
	echo
}
