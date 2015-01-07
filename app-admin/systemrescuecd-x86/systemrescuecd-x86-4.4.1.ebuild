# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/systemrescuecd-x86/systemrescuecd-x86-4.4.1.ebuild,v 1.1 2015/01/06 23:57:06 mgorny Exp $

EAPI=5

DESCRIPTION="The .iso image of SystemRescueCD rescue disk, x86 variant"
HOMEPAGE="http://www.sysresccd.org/"
SRC_URI="mirror://sourceforge/systemrescuecd/sysresccd-${PN#*-}/${PV}/${P}.iso"

LICENSE="GPL-2"
SLOT="${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

RESTRICT="mirror"

src_install() {
	insinto "/usr/share/${PN%-*}"
	doins "${DISTDIR}/${P}.iso"
}

pkg_postinst() {
	local f=${EROOT%/}/usr/share/${PN%-*}/${PN}-newest.iso

	# no newer version? we're the newest!
	if ! has_version ">${CATEGORY}/${PF}"; then
		ln -f -s -v "${P}.iso" "${f}" || die
	fi
}

pkg_postrm() {
	# TODO: best_version is probably broken in portage, figure it out
	local f=${EROOT%/}/usr/share/${PN%-*}/${PN}-newest.iso
	local newest_version=$(best_version "${CATEGORY}/${PN}")

	if [[ ${newest_version} != ${CATEGORY}/${PF} ]]; then
		# we're not the newest? update the symlink.
		ln -f -s -v "${newest_version%-r*}.iso" "${f}" || die
	elif [[ ! ${newest_version} ]]; then
		# last version removed? clean up the symlink.
		rm -v "${f}" || die
		# TODO: remove the empty directory
	fi
}
