# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/protobuf/protobuf-2.5.0.ebuild,v 1.9 2014/01/19 10:30:49 ago Exp $

EAPI=5
JAVA_PKG_IUSE="source"
PYTHON_COMPAT=( python{2_6,2_7} )
DISTUTILS_OPTIONAL=1

inherit autotools eutils distutils-r1 java-pkg-opt-2 elisp-common

DESCRIPTION="Google's Protocol Buffers -- an efficient method of encoding structured data"
HOMEPAGE="http://code.google.com/p/protobuf/"
SRC_URI="http://protobuf.googlecode.com/files/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0/8" # subslot = soname major version
KEYWORDS="amd64 ~arm ~ia64 ~mips ~ppc ppc64 x86 ~amd64-linux ~arm-linux ~x86-linux ~x64-macos x86-macos"
IUSE="emacs examples java python static-libs vim-syntax"

CDEPEND="emacs? ( virtual/emacs )
	python? ( ${PYTHON_DEPS} )"
DEPEND="${CDEPEND}
	java? ( >=virtual/jdk-1.5 )
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"
RDEPEND="${CDEPEND}
	java? ( >=virtual/jre-1.5 )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-x32.patch
	if [[ ${CHOST} != *-darwin* ]] ; then
		# breaks Darwin, bug #472514
		epatch "${FILESDIR}"/${PN}-2.3.0-asneeded-2.patch
		eautoreconf
	fi

	if use python; then
		cd python && distutils-r1_src_prepare
	fi
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_compile() {
	default

	if use python; then
		einfo "Compiling Python library ..."
		pushd python >/dev/null
		distutils-r1_src_compile
		popd >/dev/null
	fi

	if use java; then
		einfo "Compiling Java library ..."
		src/protoc --java_out=java/src/main/java --proto_path=src src/google/protobuf/descriptor.proto
		mkdir java/build
		pushd java/src/main/java >/dev/null
		ejavac -d ../../../build $(find . -name '*.java') || die "java compilation failed"
		popd >/dev/null
		jar cf ${PN}.jar -C java/build . || die "jar failed"
	fi

	if use emacs; then
		elisp-compile "${S}"/editors/protobuf-mode.el
	fi
}

src_test() {
	emake check

	if use python; then
		pushd python >/dev/null
		distutils-r1_src_test
		popd >/dev/null
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc CHANGES.txt CONTRIBUTORS.txt README.txt
	prune_libtool_files

	if use python; then
		pushd python >/dev/null
		distutils-r1_src_install
		popd >/dev/null
	fi

	if use java; then
		java-pkg_dojar ${PN}.jar
		use source && java-pkg_dosrc java/src/main/java/*
	fi

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins editors/proto.vim
		insinto /usr/share/vim/vimfiles/ftdetect/
		doins "${FILESDIR}"/proto.vim
	fi

	if use emacs; then
		elisp-install ${PN} editors/protobuf-mode.el*
		elisp-site-file-install "${FILESDIR}"/70${PN}-gentoo.el
	fi

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
