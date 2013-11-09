# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xen-tools/xen-tools-4.3.0-r3.ebuild,v 1.2 2013/11/09 08:14:57 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE='xml,threads'

IPXE_TARBALL_URL="http://dev.gentoo.org/~idella4/tarballs/ipxe.tar.gz"
XEN_SEABIOS_URL="http://dev.gentoo.org/~idella4/tarballs/seabios-dir-remote-20130720.tar.gz"

if [[ $PV == *9999 ]]; then
	KEYWORDS=""
	REPO="xen-unstable.hg"
	EHG_REPO_URI="http://xenbits.xensource.com/${REPO}"
	S="${WORKDIR}/${REPO}"
	live_eclass="mercurial"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="http://bits.xensource.com/oss-xen/release/${PV}/xen-${PV}.tar.gz
	$IPXE_TARBALL_URL
	$XEN_SEABIOS_URL"
	S="${WORKDIR}/xen-${PV}"
fi

inherit bash-completion-r1 eutils flag-o-matic multilib python-single-r1 toolchain-funcs udev ${live_eclass}

DESCRIPTION="Xend daemon and tools"
HOMEPAGE="http://xen.org/"
DOCS=( README docs/README.xen-bugtool )

LICENSE="GPL-2"
SLOT="0"
# Inclusion of IUSE ocaml on stabalizing requires aballier to (get off his hands and) make >=dev-lang/ocaml-4 stable
# Otherwise IUSE ocaml and ocaml capable build need be purged
IUSE="api custom-cflags debug doc flask hvm qemu ocaml +pam python pygrub screen static-libs xend"

REQUIRED_USE="hvm? ( qemu )
	${PYTHON_REQUIRED_USE}"

DEPEND="dev-libs/lzo:2
	dev-libs/yajl
	dev-libs/libgcrypt
	dev-python/lxml[${PYTHON_USEDEP}]
	pam? ( dev-python/pypam[${PYTHON_USEDEP}] )
	sys-libs/zlib
	sys-power/iasl
	hvm? ( media-libs/libsdl )
	${PYTHON_DEPS}
	api? ( dev-libs/libxml2
		net-misc/curl )
	pygrub? ( ${PYTHON_DEPS//${PYTHON_REQ_USE}/ncurses} )
	sys-devel/bin86
	sys-devel/dev86
	dev-lang/perl
	app-misc/pax-utils
	dev-python/markdown
	doc? (
		app-doc/doxygen
		dev-tex/latex2html[png,gif]
		media-gfx/graphviz
		dev-tex/xcolor
		media-gfx/transfig
		dev-texlive/texlive-latexextra
		virtual/latex-base
		dev-tex/latexmk
		dev-texlive/texlive-latex
		dev-texlive/texlive-pictures
		dev-texlive/texlive-latexrecommended
	)
	hvm? ( x11-proto/xproto
		!net-libs/libiscsi )
	qemu? ( x11-libs/pixman )
	ocaml? ( dev-ml/findlib
		>=dev-lang/ocaml-4 )"
RDEPEND="sys-apps/iproute2
	net-misc/bridge-utils
	screen? (
		app-misc/screen
		app-admin/logrotate
	)
	virtual/udev"

# hvmloader is used to bootstrap a fully virtualized kernel
# Approved by QA team in bug #144032
QA_WX_LOAD="usr/lib/xen/boot/hvmloader"

RESTRICT="test"

pkg_setup() {
	python-single-r1_pkg_setup
	export "CONFIG_LOMOUNT=y"

	if has_version dev-libs/libgcrypt; then
		export "CONFIG_GCRYPT=y"
	fi

	if use qemu; then
		export "CONFIG_IOEMU=y"
	else
		export "CONFIG_IOEMU=n"
	fi

	if ! use x86 && ! has x86 $(get_all_abis) && use hvm; then
		eerror "HVM (VT-x and AMD-v) cannot be built on this system. An x86 or"
		eerror "an amd64 multilib profile is required. Remove the hvm use flag"
		eerror "to build xen-tools on your current profile."
		die "USE=hvm is unsupported on this system."
	fi

	if [[ -z ${XEN_TARGET_ARCH} ]] ; then
		if use x86 && use amd64; then
			die "Confusion! Both x86 and amd64 are set in your use flags!"
		elif use x86; then
			export XEN_TARGET_ARCH="x86_32"
		elif use amd64 ; then
			export XEN_TARGET_ARCH="x86_64"
		else
			die "Unsupported architecture!"
		fi
	fi
}

src_prepare() {
	# Drop .config, fixes to gcc-4.6
	epatch "${FILESDIR}"/${PN/-tools/}-4.3-fix_dotconfig-gcc.patch

	# Xend
	if ! use xend; then
		sed -e 's:xm xen-bugtool xen-python-path xend:xen-bugtool xen-python-path:' \
			-i tools/misc/Makefile || die "Disabling xend failed"
		sed -e 's:^XEND_INITD:#XEND_INITD:' \
			-i tools/examples/Makefile || die "Disabling xend failed"
	fi

	# if the user *really* wants to use their own custom-cflags, let them
	if use custom-cflags; then
		einfo "User wants their own CFLAGS - removing defaults"

		# try and remove all the default cflags
		find "${S}" \( -name Makefile -o -name Rules.mk -o -name Config.mk \) \
			-exec sed \
				-e 's/CFLAGS\(.*\)=\(.*\)-O3\(.*\)/CFLAGS\1=\2\3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-march=i686\(.*\)/CFLAGS\1=\2\3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-fomit-frame-pointer\(.*\)/CFLAGS\1=\2\3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-g3*\s\(.*\)/CFLAGS\1=\2 \3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-O2\(.*\)/CFLAGS\1=\2\3/' \
				-i {} + || die "failed to re-set custom-cflags"
	fi

	if ! use pygrub; then
		sed -e '/^SUBDIRS-y += pygrub/d' -i tools/Makefile || die
	fi

	if ! use python; then
		sed -e '/^SUBDIRS-y += python$/d' -i tools/Makefile || die
	fi

	# Disable hvm support on systems that don't support x86_32 binaries.
	if ! use hvm; then
		sed -e '/^CONFIG_IOEMU := y$/d' -i config/*.mk || die
		sed -e '/SUBDIRS-$(CONFIG_X86) += firmware/d' -i tools/Makefile || die
	fi

	# Don't bother with qemu, only needed for fully virtualised guests
	if ! use qemu; then
		sed -e "/^CONFIG_IOEMU := y$/d" -i config/*.mk || die
		sed -e "s:install-tools\: tools/ioemu-dir:install-tools\: :g" -i Makefile || die
	fi

	# Fix texi2html build error with new texi2html, qemu.doc.html
	epatch "${FILESDIR}"/${PN}-4-docfix.patch \
		"${FILESDIR}"/${PN}-4-qemu-xen-doc.patch

	# Fix network broadcast on bridged networks
	epatch "${FILESDIR}/${PN}-3.4.0-network-bridge-broadcast.patch"

	# Prevent the downloading of ipxe, seabios
	epatch "${FILESDIR}"/${P/-tools/}-anti-download.patch
	cp "${DISTDIR}"/ipxe.tar.gz tools/firmware/etherboot/ || die
	mv ../seabios-dir-remote tools/firmware/ || die
	pushd tools/firmware/ > /dev/null
	ln -s seabios-dir-remote seabios-dir || die
	popd > /dev/null

	# Fix bridge by idella4, bug #362575
	epatch "${FILESDIR}/${PN}-4.1.1-bridge.patch"

	# Don't build ipxe with pie on hardened, Bug #360805
	if gcc-specs-pie; then
		epatch "${FILESDIR}"/ipxe-nopie.patch
	fi

	# Prevent double stripping of files at install
	epatch "${FILESDIR}"/${PN/-tools/}-4.2.0-nostrip.patch

	# fix jobserver in Makefile
	epatch "${FILESDIR}"/${PN/-tools/}-4.3-jserver.patch

	# add missing header
	epatch "${FILESDIR}"/xen-4-ulong.patch

	# Set dom0-min-mem to kb; Bug #472982
	epatch "${FILESDIR}"/${PN/-tools/}-4.2-configsxp.patch

	#Security patches, currently valid
	epatch "${FILESDIR}"/xen-4-CVE-2012-6075-XSA-41.patch \
		"${FILESDIR}"/xen-4-CVE-2013-1922-XSA-48.patch \
		"${FILESDIR}"/${PN}-4-CVE-2013-4369-XSA-68.patch \
		"${FILESDIR}"/${PN}-4-CVE-2013-4370-XSA-69.patch \
		"${FILESDIR}"/${PN}-4-CVE-2013-4371-XSA-70.patch \
		"${FILESDIR}"/${PN}-4-CVE-2013-4416-XSA-72.patch

	# Bug 472438
	sed -e 's:^BASH_COMPLETION_DIR ?= $(CONFIG_DIR)/bash_completion.d:BASH_COMPLETION_DIR ?= $(SHARE_DIR)/bash-completion:' \
		-i Config.mk || die

	# Bug 477676
	epatch "${FILESDIR}"/${PN}-4.3-ar-cc.patch

	# Prevent file collision with qemu package Bug 478064
	if use qemu; then
		epatch "${FILESDIR}"/qemu-bridge.patch
		mv tools/qemu-xen/qemu-bridge-helper.c tools/qemu-xen/xen-bridge-helper.c || die
	fi

	use flask || sed -e "/SUBDIRS-y += flask/d" -i tools/Makefile || die
	use api   || sed -e "/SUBDIRS-\$(LIBXENAPI_BINDINGS) += libxen/d" -i tools/Makefile || die
	sed -e 's:$(MAKE) PYTHON=$(PYTHON) subdirs-$@:LC_ALL=C "$(MAKE)" PYTHON=$(PYTHON) subdirs-$@:' -i tools/firmware/Makefile || die

	# Bug 379537
	epatch "${FILESDIR}"/fix-gold-ld.patch

	epatch_user
}

src_configure() {
	local myconf="--prefix=/usr --disable-werror"

	if use ocaml
	then
		myconf="${myconf} $(use_enable ocaml ocamltools)"
	else
		myconf="${myconf} --disable-ocamltools"
	fi

	if ! use pam
	then
		myconf="${myconf} --disable-pam"
	fi

	econf ${myconf}
}

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	local myopt
	use debug && myopt="${myopt} debug=y"

	use custom-cflags || unset CFLAGS
	if test-flag-CC -fno-strict-overflow; then
		append-flags -fno-strict-overflow
	fi

	unset LDFLAGS
	unset CFLAGS
	emake V=1 CC="$(tc-getCC)" LD="$(tc-getLD)" AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" -C tools ${myopt}

	use doc && emake -C docs txt html
	emake -C docs man-pages
}

src_install() {
	# Override auto-detection in the build system, bug #382573
	export INITD_DIR=/tmp/init.d
	export CONFIG_LEAF_DIR=../tmp/default

	# Let the build system compile installed Python modules.
	local PYTHONDONTWRITEBYTECODE
	export PYTHONDONTWRITEBYTECODE

	emake DESTDIR="${ED}" DOCDIR="/usr/share/doc/${PF}" \
		XEN_PYTHON_NATIVE_INSTALL=y install-tools

	# Fix the remaining Python shebangs.
	python_fix_shebang "${D}"

	# Remove RedHat-specific stuff
	rm -rf "${D}"tmp || die

	# uncomment lines in xl.conf
	sed -e 's:^#autoballoon=1:autoballoon=1:' \
		-e 's:^#lockfile="/var/lock/xl":lockfile="/var/lock/xl":' \
		-e 's:^#vifscript="vif-bridge":vifscript="vif-bridge":' \
		-i tools/examples/xl.conf  || die

	# Reset bash completion dir; Bug 472438
	mv "${D}"bash-completion "${D}"usr/share/ || die

	if use doc; then
		emake DESTDIR="${D}" DOCDIR="/usr/share/doc/${PF}" install-docs

		dohtml -r docs/
		docinto pdf
		dodoc ${DOCS[@]}
		[ -d "${D}"/usr/share/doc/xen ] && mv "${D}"/usr/share/doc/xen/* "${D}"/usr/share/doc/${PF}/html
	fi

	rm -rf "${D}"/usr/share/doc/xen/
	doman docs/man?/*

	if use xend; then
		newinitd "${FILESDIR}"/xend.initd-r2 xend || die "Couldn't install xen.initd"
	fi
	newconfd "${FILESDIR}"/xendomains.confd xendomains
	newconfd "${FILESDIR}"/xenstored.confd xenstored
	newconfd "${FILESDIR}"/xenconsoled.confd xenconsoled
	newinitd "${FILESDIR}"/xendomains.initd-r2 xendomains
	newinitd "${FILESDIR}"/xenstored.initd xenstored
	newinitd "${FILESDIR}"/xenconsoled.initd xenconsoled

	if use screen; then
		cat "${FILESDIR}"/xendomains-screen.confd >> "${D}"/etc/conf.d/xendomains || die
		cp "${FILESDIR}"/xen-consoles.logrotate "${D}"/etc/xen/ || die
		keepdir /var/log/xen-consoles
	fi

	# Move files built with use qemu, Bug #477884
	if [[ "${ARCH}" == 'amd64' ]] && use qemu; then
		mkdir -p "${D}"usr/$(get_libdir)/xen/bin || die
		mv "${D}"usr/lib/xen/bin/* "${D}"usr/$(get_libdir)/xen/bin/ || die
	fi

	# For -static-libs wrt Bug 384355
	if ! use static-libs; then
		rm -f "${D}"usr/$(get_libdir)/*.a "${D}"usr/$(get_libdir)/ocaml/*/*.a
	fi

	# xend expects these to exist
	keepdir /var/run/xenstored /var/lib/xenstored /var/xen/dump /var/lib/xen /var/log/xen

	# for xendomains
	keepdir /etc/xen/auto

	# Temp QA workaround
	dodir "$(udev_get_udevdir)"
	mv "${D}"/etc/udev/* "${D}/$(udev_get_udevdir)"
	rm -rf "${D}"/etc/udev

	# Remove files failing QA AFTER emake installs them, avoiding seeking absent files
	find "${D}" \( -name openbios-sparc32 -o -name openbios-sparc64 \
		-o -name openbios-ppc -o -name palcode-clipper \) -delete || die
}

pkg_postinst() {
	elog "Official Xen Guide and the offical wiki page:"
	elog "http://www.gentoo.org/doc/en/xen-guide.xml"
	elog "http://wiki.xen.org/wiki/Main_Page"

	if [[ "$(scanelf -s __guard -q "${PYTHON}")" ]] ; then
		echo
		ewarn "xend may not work when python is built with stack smashing protection (ssp)."
		ewarn "If 'xm create' fails with '<ProtocolError for /RPC2: -1 >', see bug #141866"
		ewarn "This problem may be resolved as of Xen 3.0.4, if not post in the bug."
	fi

	# TODO: we need to have the current Python slot here.
	if ! has_version "dev-lang/python[ncurses]"; then
		echo
		ewarn "NB: Your dev-lang/python is built without USE=ncurses."
		ewarn "Please rebuild python with USE=ncurses to make use of xenmon.py."
	fi

	if has_version "sys-apps/iproute2[minimal]"; then
		echo
		ewarn "Your sys-apps/iproute2 is built with USE=minimal. Networking"
		ewarn "will not work until you rebuild iproute2 without USE=minimal."
	fi

	if ! use hvm; then
		echo
		elog "HVM (VT-x and AMD-V) support has been disabled. If you need hvm"
		elog "support enable the hvm use flag."
		elog "An x86 or amd64 multilib system is required to build HVM support."
	fi

	if use xend; then
		elog"";elog "xend capability has been enabled and installed"
	fi

	if use qemu; then
		elog "The qemu-bridge-helper is renamed to the xen-bridge-helper in the in source"
		elog "build of qemu.  This allows for app-emulation/qemu to be emerged concurrently"
		elog "with the qemu capable xen.  It is up to the user to distinguish between and utilise"
		elog "the qemu-bridge-helper and the xen-bridge-helper.  File bugs of any issues that arise"
	fi

	if grep -qsF XENSV= "${ROOT}/etc/conf.d/xend"; then
		echo
		elog "xensv is broken upstream (Gentoo bug #142011)."
		elog "Please remove '${ROOT%/}/etc/conf.d/xend', as it is no longer needed."
	fi
}
