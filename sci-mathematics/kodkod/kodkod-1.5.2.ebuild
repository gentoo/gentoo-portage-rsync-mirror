# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/kodkod/kodkod-1.5.2.ebuild,v 1.1 2012/12/05 10:41:32 gienah Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 waf-utils

DESCRIPTION="a constraint solver for relational logic"
HOMEPAGE="http://alloy.mit.edu/kodkod/index.html"
SRC_URI="http://alloy.mit.edu/kodkod/${PV}/${P}.zip
	http://waf.googlecode.com/files/waf-1.7.6"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP=""
RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.6"
DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.6
	app-arch/unzip"

S="${WORKDIR}/kodkod-1.5"

JAVA_SRC_DIR="src"
LIBDIR="/usr/"$(get_libdir)"/${PN}"

src_unpack() {
	unpack "${A% *}"
	cp "${DISTDIR}/${A#* }" "${S}/waf" || die "Could not copy waf"
}

src_prepare() {
	java-pkg-2_src_prepare
	chmod u+x waf \
		|| die "Could not set execute permisions on waf file"
	sed -e 's@private N parent, left, right@protected N parent, left, right@' \
		-e 's@private boolean color@protected boolean color@' \
		-i "${S}/src/kodkod/util/ints/IntTree.java" \
		|| die "Could not change private to protected in IntTree.java"
	sed -e 's@conf.env.LINKFLAGS =@conf.env.LINKFLAGS +=@' \
		-i "${S}/lib/cryptominisat-2.9.1/wscript" \
		-i "${S}/lib/lingeling-276/wscript" \
		|| die "Could not fix wscripts to respect LDFLAGS"

}

# note: kodkod waf fails when passed --libdir:
# waf: error: no such option: --libdir
src_configure() {
	${WAF_BINARY:="${S}/waf"}

	tc-export AR CC CPP CXX RANLIB
	echo "CCFLAGS=\"${CFLAGS}\" LINKFLAGS=\"${LDFLAGS}\" \"${WAF_BINARY}\" --prefix=${EPREFIX}/usr $@ configure"

	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${WAF_BINARY}" \
		"--prefix=${EPREFIX}/usr" \
		"$@" \
		configure || die "configure failed"
}

src_install() {
	insinto "/usr/"$(get_libdir)
	dodir ${LIBDIR}
	exeinto ${LIBDIR}
	for i in $(find . \( -name \*.so -o -name plingeling \) -print | xargs); do
		doexe $i
	done

	for i in $(find . \( -name kodkod.jar -o -name org.sat4j.core.jar \) -print | xargs); do
		einfo "java-pkg_dojar $i"
		java-pkg_dojar $i
	done
	dosym "/usr/share/${PN}-${SLOT}/package.env" "/usr/share/${PN}/package.env"

	# javadoc
	if has doc ${JAVA_PKG_IUSE} && use doc; then
		java-pkg_dojavadoc src/kodkod
	fi

	# dosrc
	if has source ${JAVA_PKG_IUSE} && use source; then
		local srcdirs=""
		if [[ ${JAVA_SRC_DIR} ]]; then
			local parent child
			for parent in ${JAVA_SRC_DIR}; do
				for child in ${parent}/*; do
					srcdirs="${srcdirs} ${child}"
				done
			done
		else
			# take all directories actually containing any sources
			srcdirs="$(cut -d/ -f1 ${sources} | sort -u)"
		fi
		java-pkg_dosrc ${srcdirs}
	fi
}
