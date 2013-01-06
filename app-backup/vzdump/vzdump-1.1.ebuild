# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/vzdump/vzdump-1.1.ebuild,v 1.2 2009/03/23 22:07:44 mr_bones_ Exp $

EAPI="2"

DESCRIPTION="A utility to make consistent snapshots of running OpenVZ containers."
HOMEPAGE="http://www.proxmox.com/cms_proxmox/en/virtualization/openvz/vzdump/"
SRC_URI="http://www.proxmox.com/cms_proxmox/cms/upload/vzdump/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-lang/perl
	virtual/perl-Getopt-Long
	sys-cluster/vzctl
	net-misc/rsync
	app-misc/cstream
	virtual/mta
	sys-fs/lvm2"

src_compile() {
	:;
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog TODO
}
