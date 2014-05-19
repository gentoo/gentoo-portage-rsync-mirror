# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/shelx/shelx-20060317-r2.ebuild,v 1.1 2014/05/19 08:48:08 jlec Exp $

EAPI=5

inherit autotools eutils fortran-2 flag-o-matic toolchain-funcs

DESCRIPTION="Programs for crystal structure determination from single-crystal diffraction data"
HOMEPAGE="http://shelx.uni-ac.gwdg.de/SHELX/"
SRC_URI="
	${P}.tgz
	openmp? ( ${P}-mp.tgz )"

SLOT="0"
LICENSE="free-noncomm"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="dosformat openmp"

S="${WORKDIR}/unix"

RESTRICT="fetch"

pkg_nofetch() {
	elog "Go to ${HOMEPAGE}"
	elog "Fill out the application form, and send it in."
	elog "Download unix.tgz, rename it to ${P}.tgz,"
	use openmp && elog "download mp.tgz, rename it to ${P}-mp.tgz,"
	elog "and place renamed tarballs in ${DISTDIR}."
}

src_prepare() {
	EPATCH_OPTS="-p1" \
		epatch \
			"${FILESDIR}"/${PV}-autotool.patch \
			"${FILESDIR}"/${PV}-gfortran.patch

	if use openmp; then
		for i in shelxh shelxlv; do
			cp "${WORKDIR}"/mp/${i}_omp.f "${WORKDIR}"/unix/${i}.f || die
		done
	fi

	sed -i \
		-e "s:CIFDIR='/usr/local/bin/':CIFDIR='${EPREFIX}/usr/share/${PN}/':g" \
		"${S}"/ciftab.f || die

	if use dosformat; then
		sed -i \
			-e "s/KD=CHAR(32)/KD=CHAR(13)/g" \
			"${S}"/*f
	fi

	cd "${S}" || die
	eautoreconf
}

src_configure() {
	case $(tc-getF77) in
		*gfortran) append-flags -fopenmp ;;
		ifort) append-flags -openmp ;;
		*) ewarn "Please add any necessary OpenMP build flags to F77FLAGS." ;;
	esac

	econf \
		FC="$(tc-getFC)"
}

pkg_info() {
	use openmp && einfo "Set OMP_NUM_THREADS to the number of threads you want."
}

pkg_postinst() {
	pkg_info
}
