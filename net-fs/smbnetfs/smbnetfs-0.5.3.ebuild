# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/smbnetfs/smbnetfs-0.5.3.ebuild,v 1.2 2012/05/03 04:06:32 jdhore Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="FUSE filesystem for SMB shares"
HOMEPAGE="http://sourceforge.net/projects/smbnetfs"
SRC_URI="mirror://sourceforge/smbnetfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome"

RDEPEND=">=sys-fs/fuse-2.3
	>=net-fs/samba-3.2[smbclient]
	gnome? ( gnome-base/gnome-keyring )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/make"

src_prepare() {
	epatch "${FILESDIR}/smbnetfs-0.5.3-0001-configure.in-allow-user-to-explicitly-enable-disable.patch"
	eautoreconf
}

src_configure() {
	econf $(use_with gnome gnome-keyring) || die "econf failed"
}

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
