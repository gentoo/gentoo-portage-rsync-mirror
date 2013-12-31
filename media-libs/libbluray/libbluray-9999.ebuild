# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbluray/libbluray-9999.ebuild,v 1.14 2013/12/22 11:03:46 radhermit Exp $

EAPI=5

inherit autotools java-pkg-opt-2 git-r3 flag-o-matic eutils

EGIT_REPO_URI="git://git.videolan.org/libbluray.git"

DESCRIPTION="Blu-ray playback libraries"
HOMEPAGE="http://www.videolan.org/developers/libbluray.html"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="aacs java static-libs +truetype utils +xml"

COMMON_DEPEND="
	xml? ( dev-libs/libxml2 )
"
RDEPEND="
	${COMMON_DEPEND}
	aacs? ( media-libs/libaacs )
	java? (
		truetype? ( media-libs/freetype:2 )
		>=virtual/jre-1.6
	)
"
DEPEND="
	${COMMON_DEPEND}
	java? (
		truetype? ( media-libs/freetype:2 )
		>=virtual/jdk-1.6
		dev-java/ant-core
	)
	virtual/pkgconfig
"

DOCS=( ChangeLog README.txt )

src_prepare() {
	if use java ; then
		export JDK_HOME="$(java-config -g JAVA_HOME)"

		# don't install a duplicate jar file
		sed -i '/^jar_DATA/d' src/Makefile.am || die

		java-pkg-opt-2_src_prepare
	fi
	eautoreconf
}

src_configure() {
	local myconf
	if use java; then
		export JAVACFLAGS="$(java-pkg_javac-args)"
		append-cflags "$(java-pkg_get-jni-cflags)"
		myconf="$(use_with truetype freetype)"
	fi

	econf \
		--disable-optimizations \
		$(use_enable utils examples) \
		$(use_enable java bdjava) \
		$(use_enable static-libs static) \
		$(use_with xml libxml2) \
		${myconf}
}

src_install() {
	default

	if use utils; then
		cd src
		dobin index_dump mobj_dump mpls_dump
		cd .libs/
		dobin bd_info bdsplice clpi_dump hdmv_test libbluray_test list_titles sound_dump
		if use java; then
			dobin bdj_test
		fi
	fi

	if use java; then
		java-pkg_dojar "${S}"/src/.libs/${PN}.jar
		doenvd "${FILESDIR}"/90${PN}
	fi

	prune_libtool_files
}
