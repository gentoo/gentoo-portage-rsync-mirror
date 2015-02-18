# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/mpibash/mpibash-1.2.ebuild,v 1.1 2015/02/17 23:21:14 ottxor Exp $

EAPI=5

inherit autotools multilib

if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="git://github.com/losalamos/MPI-Bash.git http://github.com/losalamos/MPI-Bash.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/losalamos/MPI-Bash/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Parallel scripting right from the Bourne-Again Shell (Bash)"
HOMEPAGE="https://github.com/losalamos/MPI-Bash"

LICENSE="GPL-3"
SLOT="0"
IUSE="examples"

DEPEND="virtual/mpi
	>=app-shells/bash-4.2[plugins]
	sys-cluster/libcircle"
RDEPEND="${DEPEND}"

src_prepare() {
	[[ "${PV}" = 9999 ]] && eautoreconf
}

src_configure() {
	econf --with-bashdir="${EPREFIX}"/usr/include/bash-plugins \
		--with-plugindir="${EPREFIX}"/usr/$(get_libdir)/bash
}

src_install() {
	default
	sed -i '/^export LD_LIBRARY_PATH/d' "${ED}/usr/bin/${PN}" || die
	use examples || rm -r "${ED}/usr/share/doc/${PF}/examples" || die
}
