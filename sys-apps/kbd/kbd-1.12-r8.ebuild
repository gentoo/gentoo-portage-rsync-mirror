# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-1.12-r8.ebuild,v 1.12 2010/10/08 01:57:43 leio Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://freshmeat.net/projects/kbd/"
SRC_URI="ftp://ftp.cwi.nl/pub/aeb/kbd/${P}.tar.gz
	ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/kbd/${P}.tar.gz
	nls? ( http://www.users.one.se/liket/svorak/svorakln.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="nls"

RDEPEND=""
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	local a
	# Workaround problem on JFS filesystems, see bug 42859
	for a in ${A} ; do
		echo ">>> Unpacking ${a} to ${WORKDIR}"
		gzip -dc "${DISTDIR}"/${a} | tar xf -
		assert
	done

	cd "${S}"
	sed -i \
		-e "/^CFLAGS/ s:-O2:${CFLAGS}:g" \
		-e "/^LDFLAGS/ s:-s:${LDFLAGS}:" \
		-e "s:install -s:install:" \
		src/Makefile.in \
		openvt/Makefile

	if tc-is-cross-compiler; then
		tc-export CC
		# Cross-compiling: don't run test programs
		sed -i -e "s:&& ./conftest::" configure || \
			die "Could not do sed configure for cross-compile"
	fi

	# Other patches from RH
	epatch "${FILESDIR}"/${PN}-1.08-terminal.patch

	epatch "${FILESDIR}"/${P}-configure-LANG.patch #128253

	# Fixes a problem where loadkeys matches dvorak the dir, and not the
	# .map inside
	epatch "${FILESDIR}"/${P}-find-map-fix.patch

	# Sparc have not yet fixed struct kbd_rate to use 'period' and not 'rate'
	epatch "${FILESDIR}"/${P}-kbd_repeat-v2.patch

	# misc fixes from debian
	epatch "${FILESDIR}"/${P}-debian.patch

	# fix unimap path issue caused by Debian patch
	epatch "${FILESDIR}/${P}"-unimap.patch

	# Provide a QWERTZ and QWERTY cz map #19010
	cp data/keymaps/i386/{qwerty,qwertz}/cz.map || die "cz qwerty"
	epatch "${FILESDIR}"/${P}-cz-qwerty-map.patch

	# Fix jp map to recognize Ctrl-[ as Escape #71870
	epatch "${FILESDIR}"/${P}-jp-escape.patch

	# Patches from Fedora
	epatch "${FILESDIR}"/${P}-Meta_utf8.patch
	## Fix runtime with gcc4 (setfont: Input file: trailing garbage)
	epatch "${FILESDIR}"/${P}-alias.patch
	epatch "${FILESDIR}"/${P}-setfont-man.patch

	# cross-compile fails for powerpc targets bug #133856
	epatch "${FILESDIR}"/${P}-xcompile.patch

	# sparc newer headers lack asm/kbio.h
	epatch "${FILESDIR}"/${P}-kbio.patch
}

src_compile() {
	local myconf=
	# Non-standard configure script; --disable-nls to
	# disable NLS, nothing to enable it.
	use nls || myconf="--disable-nls"
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--datadir=/usr/share \
		${myconf} || die

	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	mv "${D}"/usr/bin/setfont "${D}"/bin/
	dosym /bin/setfont /usr/bin/setfont

	dodoc CHANGES CREDITS README
	dodir /usr/share/doc/${PF}/html
	cp -dR doc/* "${D}"/usr/share/doc/${PF}/html/

	if use nls ; then
		cd ${WORKDIR}/mnt/e/SvorakLN
		insinto /usr/share/keymaps/i386/dvorak/
		doins .svorakmap svorak.map.gz
		dodoc Svorak.txt
	fi
}
