# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/source-highlight/source-highlight-3.1.7-r1.ebuild,v 1.2 2012/07/05 06:41:17 naota Exp $

EAPI="4"

inherit bash-completion-r1 versionator

DESCRIPTION="Generate highlighted source code as an (x)html document"
HOMEPAGE="http://www.gnu.org/software/src-highlite/source-highlight.html"
SRC_URI="mirror://gnu/src-highlite/${P}.tar.gz"
LICENSE="GPL-3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
SLOT="0"
IUSE="doc static-libs"

DEPEND=">=dev-libs/boost-1.49.0
	dev-util/ctags"
RDEPEND="${DEPEND}"

src_configure() {
	BOOST_PKG="$(best_version ">=dev-libs/boost-1.35.0-r5")"
	BOOST_VER="$(replace_all_version_separators _ $(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}"))"

	sed -i \
		-e "s|ac_boost_path_tmp/include|ac_boost_path_tmp/include/boost-${BOOST_VER}|" \
		configure || die "sed failed"

	econf \
		--with-boost-regex="boost_regex-mt-${BOOST_VER}" \
		--without-bash-completion \
		$(use_enable static-libs static)
}

src_install () {
	DOCS="AUTHORS ChangeLog CREDITS NEWS README THANKS TODO.txt"
	default

	use static-libs || rm -rf "${D}"/usr/lib*/*.la

	dobashcomp completion/source-highlight

	# That's not how we want it
	rm -fr "${ED}/usr/share"/{aclocal,doc}
	use doc &&  dohtml -A java doc/*.{html,css,java}
}

src_test() {
	export LD_LIBRARY_PATH="${S}/lib/srchilite/.libs/"
	default
}
