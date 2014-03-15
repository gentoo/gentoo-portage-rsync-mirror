# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/efitools/efitools-1.4.2-r1.ebuild,v 1.2 2014/03/15 19:48:06 vapier Exp $

EAPI="4"

DESCRIPTION="Tools for manipulating UEFI secure boot platforms"
HOMEPAGE="git://git.kernel.org/pub/scm/linux/kernel/git/jejb/efitools.git"
SRC_URI="http://blog.hansenpartnership.com/wp-uploads/2013/efitools-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl
	sys-apps/util-linux"
DEPEND="${RDEPEND}
	sys-apps/help2man
	>=sys-boot/gnu-efi-3.0u
	app-crypt/sbsigntool
	virtual/pkgconfig
	dev-perl/File-Slurp"
