# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/astyle/astyle-1.22.ebuild,v 1.14 2012/07/29 16:56:41 armin76 Exp $

inherit eutils java-pkg-opt-2 multilib toolchain-funcs

DESCRIPTION="Artistic Style is a reindenter and reformatter of C++, C and Java source code"
HOMEPAGE="http://astyle.sourceforge.net/"
SRC_URI="mirror://sourceforge/astyle/astyle_${PV}_linux.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"

IUSE="debug java libs"

RDEPEND="java? ( >=virtual/jdk-1.6 )"

DEPEND="java? ( >=virtual/jdk-1.6 )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Add basic soname to make QA happy...
	sed -i -e "s:-shared:-shared -Wl,-soname,\$@ :g" buildgcc/Makefile
	# Fix JAVA_HOME
	sed -i -e \
	    "s:/usr/lib/jvm/java-6-sun-1.6.0.00:$(java-config --jdk-home):g" \
	    buildgcc/Makefile || die "sed failed"
	# respect CFLAGS, remove strip and other hard-coded crap
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	cd buildgcc

	emake CXX="$(tc-getCXX)" all $(use java && echo javaall) \
	    || die "build failed"
}

src_install() {
	if use debug ; then
	    newbin bin/astyled astyle || die "install debug bin failed"
	    newlib.a bin/libastyled.a libastyle.a  \
		|| die "install debug static lib failed"
	    if use libs ; then
		newlib.so bin/libastyled.so libastyle.so \
		    || die "install debug shared lib failed"
		if use java ; then
		    local j_dir="/usr/$(get_libdir)"
		    dolib.so bin/libastylejd.so \
			|| die "install debug shared java lib failed"
		    java-pkg_regso "${D}${j_dir}/libastylejd.so"
		fi
	    fi
	else
	    if use libs ; then
		dolib.so bin/libastyle.so || die "install shared lib failed"
		if use java ; then
		    local j_dir="/usr/$(get_libdir)"
		    dolib.so bin/libastylej.so \
			|| die "install shared java lib failed"
		    java-pkg_regso "${D}${j_dir}/libastylej.so"
		fi
	    fi
	    dobin bin/astyle || die "install bin failed"
	    dolib.a bin/libastyle.a || die "install static lib failed"
	fi
	dohtml doc/*.html
}
