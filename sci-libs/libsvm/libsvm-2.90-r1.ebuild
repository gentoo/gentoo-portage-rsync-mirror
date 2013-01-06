# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libsvm/libsvm-2.90-r1.ebuild,v 1.5 2010/04/18 17:37:00 nixnut Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit eutils java-pkg-opt-2 python toolchain-funcs multilib

MY_P="${PN}-${PV%0}"

DESCRIPTION="Library for Support Vector Machines"
HOMEPAGE="http://www.csie.ntu.edu.tw/~cjlin/libsvm/"
SRC_URI="http://www.csie.ntu.edu.tw/~cjlin/libsvm/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="java python tools"

DEPEND="java? ( >=virtual/jdk-1.4 )"
RDEPEND="${DEPEND}
	tools? ( sci-visualization/gnuplot )"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-fpic.patch
	epatch "${FILESDIR}"/${PV}-ldflags.patch
	epatch "${FILESDIR}"/${PV}-python3.patch
	python_copy_sources
}

src_compile() {
	emake \
		CXX="$(tc-getCXX)" \
		LDFLAGS="${LDFLAGS}" \
		CFLAGS="${CXXFLAGS}" \
		|| die "emake failed"

	sed -i -e 's@\.\./@/usr/bin/@g' tools/*.py \
		|| die "Failed to fix paths in python files"

	if use python ; then
		compilation () {
			pushd python
			emake \
				CXX="$(tc-getCXX)" \
				LDFLAGS="${LDFLAGS} -shared" \
				CFLAGS="${CXXFLAGS} -I$(python_get_includedir) -I.." \
				all || die "emake for python modules failed"
			popd
		}
		python_execute_function -s compilation
	fi

	if use java ; then
		pushd java
		local JAVAC_FLAGS="$(java-pkg_javac-args)"
		sed -i \
			-e "s/JAVAC_FLAGS =/JAVAC_FLAGS=${JAVAC_FLAGS}/g" \
			Makefile || die "Failed to fix java makefile"
		emake || die "emake for java modules failed"
		popd
	fi
}

src_install() {
	dobin svm-train svm-predict svm-scale \
		|| die "Failed to install binaries"
	dohtml FAQ.html || die
	dodoc README || die

	if use tools; then
		pushd tools
		insinto /usr/share/${PN}/tools
		doins easy.py grid.py subset.py \
			|| die "Failed to install python tools"
		docinto tools
		dodoc README || die
		popd
	fi

	if use python ; then
		installation() {
			pushd python
			insinto $(python_get_sitedir)
			doins svmc.so svm.py \
				|| die "Failed to install python scripts"
			docinto python
			dodoc README || die
			popd
		}
		python_execute_function -s installation
	fi

	if use java; then
		pushd java
		java-pkg_dojar libsvm.jar
		docinto java
		dohtml test_applet.html || die
		popd
	fi
}
