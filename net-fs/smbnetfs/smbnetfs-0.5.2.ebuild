# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/smbnetfs/smbnetfs-0.5.2.ebuild,v 1.2 2010/06/26 12:50:19 slyfox Exp $

EAPI=2
inherit eutils

DESCRIPTION="FUSE filesystem for SMB shares"
HOMEPAGE="http://sourceforge.net/projects/smbnetfs"
SRC_URI="mirror://sourceforge/smbnetfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=sys-fs/fuse-2.3
	>=net-fs/samba-3.2[smbclient]"

DEPEND="${RDEPEND}
	sys-devel/make"

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog
}

pkg_postinst() {
	elog
	elog "For quick usage, exec:"
	elog "'modprobe fuse'"
	elog "'smbnetfs -oallow_other /mnt/samba'"
	elog
}
