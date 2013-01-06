# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/grfcodec/grfcodec-6.0.0.ebuild,v 1.5 2012/06/07 21:08:33 ranger Exp $

EAPI=4

if [ "${PV%9999}" != "${PV}" ] ; then
	SCM=mercurial
	EHG_REPO_URI="http://hg.openttdcoop.org/${PN}"
fi

inherit toolchain-funcs ${SCM}

DESCRIPTION="A suite of programs to modify openttd/Transport Tycoon Deluxe's GRF files"
HOMEPAGE="http://dev.openttdcoop.org/projects/grfcodec"
[[ -z ${SCM} ]] && SRC_URI="http://binaries.openttd.org/extra/${PN}/${PV}/${P}-source.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE=""

[[ -n ${SCM} ]] && S=${WORKDIR}/${PN}

DEPEND="!games-util/nforenum
	dev-lang/perl
	dev-libs/boost
	media-libs/libpng"
RDEPEND=""

src_prepare() {
# Set up Makefile.local so that we respect CXXFLAGS/LDFLAGS
cat > Makefile.local <<-__EOF__
		CXX = $(tc-getCXX)
		CXXFLAGS = ${CXXFLAGS}
		LDOPT = ${LDFLAGS}
		UPX =
		V = 1
		FLAGS=
	__EOF__
}

src_install() {
	dobin ${PN} grf{diff,id,merge} nforenum
	doman docs/*.1
	dodoc changelog.txt docs/*.txt
}
