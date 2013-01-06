# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hprofile/hprofile-2.0_beta2.ebuild,v 1.3 2007/04/28 17:07:55 swegener Exp $

DESCRIPTION="Utility to manage hardware, network, power or other profiles"
HOMEPAGE="http://hprofile.sourceforge.net/"
SRC_URI="mirror://sourceforge/hprofile/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=app-shells/bash-2.0
	>=app-admin/sudo-1.6"

src_unpack() {
	unpack ${A}
	cd ${S}
	for f in $(grep /usr/local * -rl) ; do
		sed -i 's:/usr/local:/usr:g' ${f}
	done
}

src_install() {
	dosbin scripts/* || die "dosbin"

	dodir /etc/hprofile
	cp -r config/hprofile/* ${D}/etc/hprofile/ || die "cp"

	doinitd extra/rc-scripts/gentoo/*

	dodoc README
}

pkg_postinst() {
	einfo "Example profiles have been installed into /etc/hprofile/example-profiles"
	einfo "Initscripts have been been installed to /etc/init.d."
	einfo
	einfo "Scripts that should be run from the 'boot' runlevel:"
	einfo "  - hprofile      (applies the 'boot' profile)"
	einfo "  - hprunlevel    (switches to profile-specific runlevel)"
	einfo "Scripts that should be run from your default runlevel:"
	einfo "  - net.profile   (applies the current 'net' profile)"
	einfo "  - power-profile (applies the current 'power' profile)"
	einfo
	einfo "If you get an error message that 'hprunlevel' and 'local' have a"
	einfo "circular dependency of type 'iafter', this is not a problem, since"
	einfo "'hprunlevel' and 'local' are not started from the same runlevel"
	einfo
	einfo "Also note that the file /etc/runlevels/.critical has been created."
	einfo "This file contains the 'critical' boot services; since hprofile"
	einfo "should be started before modules (which is a critical service),"
	einfo "it must be mentioned in this file."
}
