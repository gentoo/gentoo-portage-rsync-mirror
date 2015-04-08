# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catalyst/catalyst-2.9999.ebuild,v 1.13 2014/01/18 11:38:05 vapier Exp $

EAPI=5

if [[ ${PV} == *9999* ]]; then
	SRC_ECLASS="git-2"
	EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/catalyst.git"
	EGIT_MASTER="master"
	EGIT_BRANCH="3.0"
	SRC_URI=""
	KEYWORDS=""
	S="${WORKDIR}/${PN}"
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://dev.gentoo.org/~jmbsvicetto/distfiles/${P}.tar.bz2
		http://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.bz2"
	KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
fi

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 multilib ${SRC_ECLASS}

DESCRIPTION="Release metatool used for creating releases based on Gentoo Linux"
HOMEPAGE="http://www.gentoo.org/proj/en/releng/catalyst/"

LICENSE="GPL-2"
SLOT="0"
IUSE="ccache doc kernel_linux"

DEPEND="
	app-text/asciidoc
	>=dev-python/snakeoil-0.5.2
"
RDEPEND="
	app-arch/lbzip2
	app-crypt/shash
	virtual/cdrtools
	amd64? ( >=sys-boot/syslinux-3.72 )
	ia64? ( sys-fs/dosfstools )
	x86? ( >=sys-boot/syslinux-3.72 )
	ccache? ( dev-util/ccache )
	kernel_linux? ( app-misc/zisofs-tools >=sys-fs/squashfs-tools-2.1 )
"

python_prepare_all() {
	python_export_best
	echo VERSION="${PV}" "${PYTHON}" setup.py set_version
	VERSION="${PV}" "${PYTHON}" setup.py set_version
}

python_compile_all() {
	# build the man pages and docs
	emake
}

python_install_all(){
	distutils-r1_python_install_all
	if use doc; then
		dodoc files/HOWTO.html files/docbook-xsl.css
	fi
}
