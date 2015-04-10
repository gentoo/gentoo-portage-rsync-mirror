# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/snns/snns-4.3-r1.ebuild,v 1.2 2015/04/10 20:09:40 axs Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
DISTUTILS_OPTIONAL=1
inherit distutils-r1 eutils

MY_P="SNNSv${PV}"
DESCRIPTION="Stuttgart Neural Network Simulator"
HOMEPAGE="http://sourceforge.net/projects/snns/"
SRC_URI="http://www.ra.cs.uni-tuebingen.de/downloads/SNNS/${MY_P}.tar.gz
	doc? ( http://www.ra.cs.uni-tuebingen.de/downloads/SNNS/SNNSv4.2.Manual.pdf )"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="X doc python"

RDEPEND="X? ( x11-libs/libXaw3d )
	python? ( ${PYTHON_DEPS} )"
DEPEND=">=sys-devel/bison-1.2.2
	X? (
		x11-libs/libXaw3d
		x11-proto/xproto
	)"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/4.3-unstrip.patch
	epatch "${FILESDIR}"/4.3-bison-version.patch
	epatch "${FILESDIR}"/4.2-ldflags.patch

	# change all references of Xaw to Xaw3d
	cd "${S}"/xgui/sources
	for file in *.c; do
		sed -e "s:X11/Xaw/:X11/Xaw3d/:g" -i "${file}"
	done

	# clean up files that apparently are not removed by any clean rules
	rm -Rf "${S}"/{tools,xgui}/bin \
		"${S}"/{Makefile.def,config.h} \
		"${S}"/configuration/config.{guess,log}

	epatch_user

	if use python; then
		pushd "${S}"/python > /dev/null || die
		distutils-r1_src_prepare
		popd > /dev/null || die
	fi
}

src_configure() {
	econf --enable-global \
		$(use_with X x)

	if use python; then
		pushd python > /dev/null || die
		distutils-r1_src_configure
		popd > /dev/null || die
	fi
}

src_compile() {
	local compileopts=( compile-kernel compile-tools )
	use X && compileopts+=( compile-xgui )

	# tarball is sometimes left dirty
	emake clean

	# parallel make sometimes fails (phosphan)
	# so emake each phase separately (axs)
	for tgt in "${compileopts[@]}"; do
		emake ${tgt}
	done

	if use python; then
		pushd python > /dev/null || die
		distutils-r1_src_compile
		popd > /dev/null || die
	fi
}

src_install() {
	for file in `find tools -type f -perm +100`; do
		dobin $file
	done

	# bug 248322
	mv "${ED}"/usr/bin/{,snns-}netperf || die

	if use X; then
		newbin xgui/sources/xgui snns

		echo XGUILOADPATH=/usr/share/doc/${PF} > "${T}"/99snns
		doenvd "${T}"/99snns

		docompress -x /usr/share/doc/${PF}/{default.cfg,help.hdoc}
		insinto /usr/share/doc/${PF}
		doins default.cfg help.hdoc
	fi

	if use python; then
		pushd python > /dev/null || die
		distutils-r1_src_install
		insinto /usr/share/doc/${PF}/python-examples
		doins examples/*
		newdoc README README.python
		popd > /dev/null || die
	fi

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/${MY_P}.Manual.pdf
	fi

	insinto /usr/share/doc/${PF}/examples
	doins examples/*
	doman man/man*/*
}
