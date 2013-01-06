# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/ubin-wrappers/ubin-wrappers-0.ebuild,v 1.2 2012/12/08 09:06:05 ulm Exp $

EAPI=4

DESCRIPTION="/usr/bin wrapper scripts for FreeBSD script compatibility"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="userland_BSD userland_GNU"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install()
{

	into /usr/bin
	"${FILESDIR}/dowrap" "${EPREFIX}/bin/"{bunzip2,bzcat,cpio,egrep,fgrep,grep,gunzip,gzip,zcat}
	use userland_BSD && "${FILESDIR}/dowrap" "${EPREFIX}/bin/sort"
	use userland_GNU && "${FILESDIR}/dowrap" "${EPREFIX}/bin/"{fuser,sed,uncompress}

}
