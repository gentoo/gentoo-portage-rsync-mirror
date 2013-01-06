# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiv2/exiv2-0.21.1-r1.ebuild,v 1.7 2012/07/02 21:51:47 sbriesen Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit eutils multilib toolchain-funcs python

DESCRIPTION="EXIF and IPTC metadata C++ library and command line utility"
HOMEPAGE="http://www.exiv2.org/"
SRC_URI="http://www.exiv2.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="contrib doc examples nls xmp zlib"
IUSE_LINGUAS="de es fi fr pl ru sk"
IUSE="${IUSE} $(printf 'linguas_%s ' ${IUSE_LINGUAS})"

RDEPEND="
	virtual/libiconv
	nls? ( virtual/libintl )
	xmp? ( dev-libs/expat )
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}
	contrib? ( >=dev-libs/boost-1.37 )
	doc? (
		app-doc/doxygen
		dev-libs/libxslt
		virtual/pkgconfig
		media-gfx/graphviz
	)
	nls? ( sys-devel/gettext )
"

src_prepare() {
	# exiv2 fails to build with boost-1.46 due to boost filesystem
	# API v3 becoming the default. This is easily fixed by adding a
	#  #define BOOST_FILESYSTEM_VERSION 2
	# to source files that include boost/filesystem.hpp
	#
	# Implemented via sed to avoid patch-file (bug #357605)
	sed -i -e \
		's|^\(#include <boost/filesystem.hpp>.*\)|#define BOOST_FILESYSTEM_VERSION 2\n\1|g' \
		contrib/organize/helpers.hpp

	# fix for off by 1 hour date error for -T option (bug #368419)
	epatch "${FILESDIR}/${P}-time-fix.patch"

	# convert docs to UTF-8
	for i in doc/cmd.txt; do
		einfo "Converting "${i}" to UTF-8"
		iconv -f LATIN1 -t UTF-8 "${i}" > "${i}~" && mv -f "${i}~" "${i}" || rm -f "${i}~"
	done

	if use doc; then
		einfo "Updating doxygen config"
		doxygen 2>&1 >/dev/null -u config/Doxyfile
	fi

	if use contrib; then
		# create build environment for contrib
		ln -snf ../../src contrib/organize/exiv2
		sed -i -e 's:/usr/local/include/.*:/usr/include:g' \
			-e 's:/usr/local/lib/lib:-l:g' -e 's:-gcc..-mt-._..\.a::g' \
			contrib/organize/boost.mk
	fi

	# fix python shebang
	python_convert_shebangs -r 2 doc/templates
}

src_configure() {
	local myconf="$(use_enable nls) $(use_enable xmp)"
	use zlib || myconf="${myconf} --without-zlib"  # plain 'use_with' fails

	# Bug #78720. amd64/gcc-3.4/-fvisibility* fail.
	if [[ $(gcc-major-version) -lt 4 ]]; then
		use amd64 && myconf="${myconf} --disable-visibility"
	fi

	econf \
		--disable-static \
		${myconf}
}

src_compile() {
	emake || die "emake failed"

	if use contrib; then
		emake -C contrib/organize \
			LDFLAGS="\$(BOOST_LIBS) -L../../src -lexiv2 ${LDFLAGS}" \
			CPPFLAGS="${CPPFLAGS} -I\$(BOOST_INC_DIR) -I. -DEXV_HAVE_STDINT_H" \
		|| die "emake organize failed"
	fi

	if use doc; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	find "${ED}" -name '*.la' -exec rm -f {} +

	if use contrib; then
		emake DESTDIR="${D}" -C contrib/organize install || die "emake install organize failed"
	fi

	dodoc README doc/{ChangeLog,cmd.txt}
	use xmp && dodoc doc/{COPYING-XMPSDK,README-XMP,cmdxmp.txt}
	use doc && dohtml -r doc/html/.
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins samples/*.cpp
	fi
}

pkg_postinst() {
	ewarn
	ewarn "PLEASE PLEASE take note of this:"
	ewarn "Please make *sure* to run revdep-rebuild now"
	ewarn "Certain things on your system may have linked against a"
	ewarn "different version of exiv2 -- those things need to be"
	ewarn "recompiled. Sorry for the inconvenience!"
	ewarn
}
