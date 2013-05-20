# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-2.4.47.ebuild,v 1.1 2013/05/20 18:43:16 vapier Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="Extended attributes tools"
HOMEPAGE="http://savannah.nongnu.org/projects/attr"
SRC_URI="mirror://nongnu/${PN}/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~arm-linux ~x86-linux"
IUSE="nls static-libs"

DEPEND="nls? ( sys-devel/gettext )
	sys-devel/autoconf"
RDEPEND=""

src_prepare() {
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		-e '/HAVE_ZIPPED_MANPAGES/s:=.*:=false:' \
		include/builddefs.in \
		|| die
	strip-linguas -u po
}

src_configure() {
	unset PLATFORM #184564
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	econf \
		$(use_enable nls gettext) \
		--enable-shared $(use_enable static-libs static) \
		--libexecdir="${EPREFIX}"/usr/$(get_libdir) \
		--bindir="${EPREFIX}"/bin
}

src_install() {
	emake DIST_ROOT="${D}" install install-lib install-dev
	use static-libs || find "${ED}" -name '*.la' -delete
	# the man-pages packages provides the man2 files
	rm -r "${ED}"/usr/share/man/man2 || die

	# we install attr into /bin, so we need the shared lib with it
	gen_usr_ldscript -a attr
}
