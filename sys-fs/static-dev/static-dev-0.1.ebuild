# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/static-dev/static-dev-0.1.ebuild,v 1.14 2011/07/21 01:56:04 vapier Exp $

DESCRIPTION="A skeleton, statically managed /dev"
HOMEPAGE="http://bugs.gentoo.org/107875"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/makedev"

pkg_preinst() {
	if [[ -d ${ROOT}/dev/.udev || -c ${ROOT}/dev/.devfs ]] ; then
		echo ""
		eerror "We have detected that you currently use udev or devfs"
		eerror "and this ebuild cannot install to the same mount-point."
		eerror "Please reinstall the ebuild (as root) like follows:"
		eerror ""
		eerror "mkdir /tmp/newroot"
		eerror "mount -o bind / /tmp/newroot"
		eerror "ROOT=/tmp/newroot/ emerge sys-fs/static-dev"
		eerror "umount /tmp/newroot"
		die "Cannot install on udev/devfs tmpfs."
	fi
}

pkg_postinst() {
	MAKEDEV -d "${ROOT}"/dev generic sg scd rtc hde hdf hdg hdh input audio video
}
