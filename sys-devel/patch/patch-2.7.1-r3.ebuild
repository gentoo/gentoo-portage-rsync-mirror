# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/patch/patch-2.7.1-r3.ebuild,v 1.1 2013/10/15 08:32:57 polynomial-c Exp $

EAPI=4

inherit flag-o-matic eutils

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="http://www.gnu.org/software/patch/patch.html"
SRC_URI="mirror://gnu/patch/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~ppc-aix ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static test xattr"

RDEPEND="xattr? ( sys-apps/attr )"
DEPEND="${RDEPEND}
	test? ( sys-apps/ed )"

src_prepare() {
	epatch "${FILESDIR}/${P}-Fix-removing-empty-directories.patch" \
		"${FILESDIR}/${P}-dry-run-mode-create-temp-files-in-temp-dir.patch" \
		"${FILESDIR}/${P}-initialize_data_structures_early_enough.patch" \
		"${FILESDIR}/${P}-prevent_depend_on_autotools.patch"
}

src_configure() {
	use static && append-ldflags -static

	# Do not let $ED mess up the search for `ed` 470210.
	ac_cv_path_ED=$(type -P ed) \
	econf \
		$(use_enable xattr) \
		--program-prefix="$(use userland_BSD && echo g)"
}
