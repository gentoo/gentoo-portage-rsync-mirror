# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kuroevtd/kuroevtd-1.1.3.ebuild,v 1.3 2007/07/02 15:27:48 peper Exp $

DESCRIPTION="Monitors the Kurobox and LinkStation power and reset buttons."
HOMEPAGE="http://kuro.dsk.jp/"
SRC_URI="http://kuro.dsk.jp/data/bin/${PN}_${PV}.tgz"

RESTRICT="mirror strip"
LICENSE="as-is"
SLOT="0"

KEYWORDS="ppc"
IUSE=""

DEPEND="sys-apps/sed"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	sed -i -e 's:/etc/kuroevtd:\0.d:' \
		${S}/kuroevtd.c ${S}/README
}

src_compile() {
	make kuroevtd || die "Failed to compile kuroevtd."
}

src_install() {

	dodir /usr/sbin
	dosbin kuroevtd
	dodoc README

	dodir /etc/init.d
	newinitd "${FILESDIR}/kuroevtd.initd" kuroevtd

	dodir /etc/kuroevtd.d
	exeinto /etc/kuroevtd.d
	local button evt script
	for button in power reset ; do
		for evt in up down press ; do
			script="${FILESDIR}/kuroevtd.d/${button}${evt}"
			if [ -f "${script}" ] ; then
				doexe "${script}"
			else
				echo "#!/bin/sh" > "${button}${evt}"
				doexe "${button}${evt}"
			fi
		done
	done

	dodir /var/lib/kuroevtd
	keepdir /var/lib/kuroevtd
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ] \
	&& [ ! -f /etc/runlevels/boot/kuroevtd ] ; then
		rc-update add kuroevtd boot
	fi
}

pkg_postrm() {
	if [ "${ROOT}" = "/" ] \
	&& [ ! -f /usr/sbin/kuroevtd ] ; then
		rc-update del kuroevtd boot
	fi
}
