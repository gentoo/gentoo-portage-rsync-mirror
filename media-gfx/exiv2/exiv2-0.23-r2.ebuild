# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiv2/exiv2-0.23-r2.ebuild,v 1.2 2013/12/22 12:18:11 johu Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
inherit eutils multilib toolchain-funcs python-single-r1 autotools-multilib

DESCRIPTION="EXIF and IPTC metadata C++ library and command line utility"
HOMEPAGE="http://www.exiv2.org/"
SRC_URI="http://www.exiv2.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/12"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE_LINGUAS="de es fi fr pl ru sk"
IUSE="contrib doc examples nls xmp zlib static-libs $(printf 'linguas_%s ' ${IUSE_LINGUAS})"

RDEPEND="
	virtual/libiconv
	nls? ( virtual/libintl )
	xmp? ( dev-libs/expat )
	zlib? ( sys-libs/zlib )
"

DEPEND="${RDEPEND}
	contrib? ( >=dev-libs/boost-1.44 )
	doc? (
		app-doc/doxygen
		dev-libs/libxslt
		virtual/pkgconfig
		media-gfx/graphviz
		${PYTHON_DEPEND}
	)
	nls? ( sys-devel/gettext )
"

DOCS=( README doc/ChangeLog doc/cmd.txt )

src_prepare() {
	# convert docs to UTF-8
	local i
	for i in doc/cmd.txt; do
		einfo "Converting "${i}" to UTF-8"
		iconv -f LATIN1 -t UTF-8 "${i}" > "${i}~" && mv -f "${i}~" "${i}" || rm -f "${i}~"
	done

	if use doc; then
		einfo "Updating doxygen config"
		doxygen 2>&1 >/dev/null -u config/Doxyfile
		python_convert_shebangs -r 2 doc/templates
	fi

	if use contrib; then
		epatch "${FILESDIR}/${P}-boost-fs-contrib.patch"

		# create build environment for contrib
		ln -snf ../../src contrib/organize/exiv2
		sed -i -e 's:/usr/local/include/.*:/usr/include:g' \
			-e 's:/usr/local/lib/lib:-l:g' -e 's:-gcc..-mt-._..\.a::g' \
			contrib/organize/boost.mk
	fi

	# set locale to safe value for the sed commands (bug #382731)
	sed -i -r "s,(\s+)sed\s,\1LC_ALL="C" sed ,g" src/Makefile

	multilib_copy_sources
}

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
		$(use_enable xmp)
		$(use_enable static-libs static)
	)

	# plain 'use_with' fails
	use zlib || myeconfargs+=("${myconf} --without-zlib")

	# Bug #78720. amd64/gcc-3.4/-fvisibility* fail.
	if [ $(gcc-major-version) -lt 4 ]; then
		use amd64 && myeconfargs+=("${myconf} --disable-visibility")
	fi

	autotools-multilib_src_configure
}

src_compile() {
	autotools-multilib_src_compile

	if use contrib; then
		autotools-multilib_src_compile -C contrib/organize \
			LDFLAGS="\$(BOOST_LIBS) -L../../src -lexiv2 ${LDFLAGS}" \
			CPPFLAGS="${CPPFLAGS} -I\$(BOOST_INC_DIR) -I. -DEXV_HAVE_STDINT_H"
	fi

	use doc && multilib_for_best_abi emake doc
}

src_install() {
	autotools-multilib_src_install

	if use contrib; then
		autotools-multilib_src_install -C contrib/organize \
			DESTDIR="${D}" install
	fi

	use xmp && dodoc doc/{COPYING-XMPSDK,README-XMP,cmdxmp.txt}
	use doc && multilib_for_best_abi dohtml -r doc/html/.
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		docompress -x /usr/share/doc/${PF}/examples
		doins samples/*.cpp
	fi
}
