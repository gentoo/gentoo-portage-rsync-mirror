# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dpkg/dpkg-1.17.9.ebuild,v 1.5 2014/05/11 08:05:12 ago Exp $

EAPI=5
inherit eutils multilib autotools toolchain-funcs

DESCRIPTION="Package maintenance system for Debian"
HOMEPAGE="http://packages.qa.debian.org/dpkg"
SRC_URI="mirror://debian/pool/main/d/${PN}/${P/-/_}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ppc ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-solaris ~x86-solaris"
IUSE="+bzip2 dselect +lzma nls test unicode +update-alternatives +zlib"
REQUIRED_USE="dselect? ( nls )"

RDEPEND="
	>=dev-lang/perl-5.6.0
	dev-perl/TimeDate
	>=sys-libs/ncurses-5.2-r7
	lzma? ( app-arch/xz-utils )
	zlib? ( >=sys-libs/zlib-1.1.4 )
	bzip2? ( app-arch/bzip2 )
"
DEPEND="
	${RDEPEND}
	app-arch/xz-utils
	sys-devel/flex
	virtual/pkgconfig
	nls? (
		app-text/po4a
		>=sys-devel/gettext-0.18.2
	)
	test? (
		dev-perl/DateTime-Format-DateParse
		dev-perl/IO-String
		dev-perl/Test-Pod
		virtual/perl-Test-Harness
	)
"

DOCS=( ChangeLog THANKS TODO )

src_prepare() {
	# do not expect Debian's gzip --rsyncable extension
	epatch "${FILESDIR}"/${PN}-1.17.0-gzip-rsyncable.patch

	epatch "${FILESDIR}"/${PN}-1.17.1-flags.patch

	# Force the use of the running bash for get-version (this file is never
	# installed, so no need to worry about hardcoding a temporary bash)
	sed -i -e '1c\#!'"${BASH}" get-version || die

	# this test depends on a Debian only gzip extension that adds --rsyncable
	# which will therefore always fail on Gentoo. (bug #310847).
	sed -i scripts/Makefile.am \
		-e '/850_Dpkg_Compression.t/d' \
		|| die "sed failed"

	# test fails (bug #414095)
	sed -i utils/Makefile.am \
		-e '/^test_cases/d;/100_update_alternatives/d' || die

	use nls && strip-linguas -i po

	eautoreconf
}

src_configure() {
	tc-export CC
	econf \
		$(use_enable dselect) \
		$(use_enable nls) \
		$(use_enable unicode) \
		$(use_enable update-alternatives) \
		$(use_with bzip2 bz2) \
		$(use_with zlib) \
		$(use_with lzma liblzma) \
		--disable-compiler-warnings \
		--disable-silent-rules \
		--disable-start-stop-daemon \
		--localstatedir="${EPREFIX}"/var \
		--without-selinux
}

src_compile() {
	emake AR=$(tc-getAR)
}

src_install() {
	default

	keepdir /usr/$(get_libdir)/db/methods/{mnt,floppy,disk}
	keepdir /usr/$(get_libdir)/db/{alternatives,info,methods,parts,updates}
}
