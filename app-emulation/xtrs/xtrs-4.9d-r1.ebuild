# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xtrs/xtrs-4.9d-r1.ebuild,v 1.4 2012/11/20 20:44:05 ago Exp $

EAPI=4

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Radio Shack TRS-80 emulator"
HOMEPAGE="http://www.tim-mann.org/xtrs.html"
SRC_URI="http://www.tim-mann.org/trs80/${P}.tar.gz
	ldos? ( http://www.tim-mann.org/trs80/ld4-631.zip )"

LICENSE="xtrs ldos? ( freedist )"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="ldos"

DEPEND="sys-libs/ncurses
	sys-libs/readline
	>=x11-libs/libX11-1.0.0"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/$(CC) -o/$(CC) $(LDFLAGS) -o/' Makefile || die
}

src_compile() {
	use ppc && append-flags -Dbig_endian
	emake CC="$(tc-getCC)" DEBUG="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		DISKDIR="-DDISKDIR='\"/usr/share/xtrs\"'" \
		DEFAULT_ROM="-DDEFAULT_ROM='\"/usr/share/xtrs/romimage\"' \
			-DDEFAULT_ROM3='\"/usr/share/xtrs/romimage.m3\"' \
			-DDEFAULT_ROM4P='\"/usr/share/xtrs/romimage.m4p\"'"
}

src_install() {
	dodir /usr/bin /usr/share/xtrs/disks /usr/share/man/man1
	emake PREFIX="${D}"/usr install

	insopts -m0444
	insinto /usr/share/xtrs/disks
	doins cpmutil.dsk utility.dsk

	if use ldos; then
		doins "${WORKDIR}"/ld4-631.dsk
		dosym disks/ld4-631.dsk /usr/share/xtrs/disk4p-0
		dosym disks/utility.dsk /usr/share/xtrs/disk4p-1
	fi

	dodoc ChangeLog README xtrsrom4p.README cpmutil.html dskspec.html
}

pkg_postinst() {
	ewarn "For copyright reasons, xtrs does not include actual ROM images."
	ewarn "Because of this, unless you supply your own ROM, xtrs will"
	ewarn "not function in any mode except 'Model 4p' mode (a minimal"
	ewarn "free ROM is included for this), which can be run like this:"
	ewarn "    xtrs -model 4p"
	elog ""
	elog "If you already own a copy of the ROM software (e.g., if you have"
	elog "a TRS-80 with this ROM), then you can make yourself a copy of this"
	elog "for use with xtrs using utilities available on the web.  You can"
	elog "also often find various ROMs elsewhere.  To load your own ROM,"
	elog "specify the '-romfile' option."
}
