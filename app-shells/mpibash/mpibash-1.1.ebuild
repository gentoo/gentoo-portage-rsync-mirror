# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/mpibash/mpibash-1.1.ebuild,v 1.1 2015/02/13 23:26:09 ottxor Exp $

EAPI=5

DESCRIPTION="Parallel scripting right from the Bourne-Again Shell (Bash)"
HOMEPAGE="https://github.com/losalamos/MPI-Bash"
SRC_URI="https://github.com/losalamos/MPI-Bash/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

DEPEND="virtual/mpi
	>=app-shells/bash-4.2[plugins]
	sys-cluster/libcircle"
RDEPEND="${DEPEND}"

src_configure() {
	econf --with-bashdir="${EPREFIX}"/usr/include/bash-plugins
}

src_install() {
	default
	use examples || rm -r "${ED}/usr/share/doc/${PF}/examples" || die
}
