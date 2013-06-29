# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dpkg/dpkg-1.16.10.ebuild,v 1.12 2013/06/29 16:23:55 ago Exp $

EAPI=4
inherit eutils multilib autotools toolchain-funcs

DESCRIPTION="Package maintenance system for Debian"
HOMEPAGE="http://packages.qa.debian.org/dpkg"
SRC_URI="mirror://debian/pool/main/d/${PN}/${P/-/_}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ppc ppc64 ~s390 ~sh sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-solaris ~x86-solaris"
IUSE="bzip2 dselect nls test unicode zlib"

LANGS="
	ast bs ca cs da de dz el eo es et eu fr gl hu id it ja km ko ku lt mr nb ne
	nl nn pa pl pt_BR pt ro ru sk sv th tl vi zh_CN zh_TW
"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND=">=dev-lang/perl-5.6.0
	dev-perl/TimeDate
	>=sys-libs/ncurses-5.2-r7
	zlib? ( >=sys-libs/zlib-1.1.4 )
	bzip2? ( app-arch/bzip2 )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	nls? ( app-text/po4a )
	sys-devel/flex
	virtual/pkgconfig
	test? (
		dev-perl/DateTime-Format-DateParse
		dev-perl/IO-String
		dev-perl/Test-Pod
	)"
REQUIRED_USE="dselect? ( nls )"

src_prepare() {
	# do not expect Debian's gzip --rsyncable extension
	epatch "${FILESDIR}"/${PN}-1.16.4.2-gzip-rsyncable.patch

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

	eautoreconf
}

src_configure() {
	tc-export CC
	econf \
		$(use_enable dselect) \
		$(use_enable unicode) \
		$(use_with bzip2 bz2) \
		$(use_with zlib) \
		${myconf} \
		--disable-compiler-optimisations \
		--disable-compiler-warnings \
		--disable-linker-optimisations \
		--disable-silent-rules \
		--disable-start-stop-daemon \
		--localstatedir="${EPREFIX}"/var \
		--without-selinux
}

src_compile() {
	emake AR=$(tc-getAR)
}

src_install() {
	strip-linguas ${LANGS}
	if [ -z "${LINGUAS}" ] ; then
		LINGUAS=none
	fi

	emake DESTDIR="${D}" LINGUAS="${LINGUAS}" install
	rm "${ED}"/usr/sbin/install-info || die "rm install-info failed"
	dodoc ChangeLog THANKS TODO
	keepdir /usr/$(get_libdir)/db/methods/{mnt,floppy,disk}
	keepdir /usr/$(get_libdir)/db/{alternatives,info,methods,parts,updates}
}
