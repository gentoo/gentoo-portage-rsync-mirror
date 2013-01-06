# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl/cmucl-19c.ebuild,v 1.11 2012/10/24 19:07:00 ulm Exp $

EAPI=1

inherit common-lisp-common-2 eutils toolchain-funcs

DEB_PV=1
MY_PV=${PV}-release-20051115

DESCRIPTION="CMU Common Lisp is an implementation of ANSI Common Lisp"
HOMEPAGE="http://www.cons.org/cmucl/
	http://packages.debian.org/unstable/devel/cmucl.html"
SRC_URI="mirror://gentoo/cmucl_${MY_PV}.orig.tar.gz
	mirror://gentoo/cmucl_${MY_PV}-${DEB_PV}.diff.gz
	mirror://gentoo/${P}-x86-linux.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE="doc nosource"

DEPEND=">=dev-lisp/common-lisp-controller-4
	doc? ( virtual/latex-base )
	>=x11-libs/motif-2.3:0
	sys-devel/bc"

S=${WORKDIR}/cmucl-${MY_PV}.orig

src_unpack() {
	unpack ${A}
	epatch cmucl_${MY_PV}-${DEB_PV}.diff
	epatch "${FILESDIR}/${PV}/herald-save.lisp-gentoo.patch"

	find "${S}" -type f \( -name \*.sh -o -name linux-nm \) \
		-exec chmod +x '{}' \;
}

src_compile() {
	export SANDBOX_ON=0

	sed -i -e "s,CC = .*,CC = $(tc-getCC),g" \
		src/lisp/Config.linux_gencgc

	PATH=${WORKDIR}/bin:$PATH CMUCLCORE=${WORKDIR}/lib/cmucl/lib/lisp.core make || die

	if use doc; then
		make -C src/docs
	fi
}

src_install() {
	insinto /usr/lib/cmucl/include
	doins src/lisp/*.h target/lisp/*.h target/lisp/*.map target/lisp/*.nm
	insinto /usr/lib/cmucl
	cp target/lisp/lisp.core lisp-dist.core
	doins lisp-dist.core

	dodoc target/lisp/lisp.{nm,map}
	doman src/general-info/{cmucl,lisp}.1

	dobin target/lisp/lisp
	dobin own-work/Demos/lisp-start

	insinto /usr/lib/cmucl
	doins own-work/install-clc.lisp
	exeinto /usr/lib/common-lisp/bin
	newexe own-work/cmucl-script.sh cmucl.sh

	insinto /etc/common-lisp/cmucl
	sed "s,@PF@,${PF},g" <"${FILESDIR}/${PV}/site-init.lisp.in" >site-init.lisp
	doins site-init.lisp
	dosym /etc/common-lisp/cmucl/site-init.lisp /usr/lib/cmucl/site-init.lisp

	dodir /etc/env.d
	cat >"${D}"/etc/env.d/50cmucl <<EOF
# CMUCLLIB=/usr/lib/cmucl
EOF
	[ -f /etc/lisp-config.lisp ] || touch "${D}"/etc/lisp-config.lisp

	insinto /usr/share/doc/${P}/html/Basic-tutorial
	doins own-work/tutorials/Basic-tutorial/*
	insinto /usr/share/doc/${P}/html/Clos
	doins own-work/tutorials/Clos/*
	docinto notes
	dodoc own-work/tutorials/notes/*

	insinto /usr/lib/cmucl
	doins own-work/hemlock11.*

	if use doc; then
		dodoc src/docs/*/*.{ps,pdf}
	fi

	exeinto /usr/lib/cmucl
	doexe target/motif/server/motifd

	# subsystems
	insinto /usr/lib/cmucl/subsystems/
	doins target/interface/clm-library.x86f \
		target/pcl/simple-streams-library.x86f \
		target/pcl/iodefs-library.x86f \
		target/pcl/gray-compat-library.x86f \
		target/hemlock/hemlock-library.x86f \
		target/pcl/gray-streams-library.x86f \
		target/clx/clx-library.x86f

	# Previously installed from dev-lisp/cmucl-source
	if ! use nosource; then
		dodir /usr/share/common-lisp/source/cmucl
		(cd src ; find . -name \*.lisp -and -type f | tar --create --file=- --files-from=- ) |\
			tar --extract --file=- -C "${D}"/usr/share/common-lisp/source/cmucl
		dodir /usr/share/common-lisp/systems
	fi

	# cmucl-graystream
	insinto /usr/share/common-lisp/source/cmucl-graystream
	doins src/pcl/gray-streams* own-work/cmucl-graystream.asd
	dosym /usr/share/common-lisp/source/cmucl-graystream/cmucl-graystream.asd \
		/usr/share/common-lisp/systems/

	# cmucl-clx
	insinto /usr/share/common-lisp/source/cmucl-clx
	cp -r src/clx/*.lisp own-work/cmucl-clx.asd \
		src/code/clx-ext.lisp \
		src/hemlock/charmacs.lisp \
		src/hemlock/key-event.lisp \
		src/hemlock/keysym-defs.lisp \
		"${D}"/usr/share/common-lisp/source/cmucl-clx
	insinto /usr/share/common-lisp/source/cmucl-clx/debug
	doins src/clx/debug/*.lisp
	insinto /usr/share/common-lisp/source/cmucl-clx/demo
	doins src/clx/demo/*.lisp
	insinto /usr/share/common-lisp/source/cmucl-clx/test
	doins src/clx/test/*.lisp
#	find ${D}/usr/share/common-lisp/source/cmucl-clx -type f -print0 | xargs -0 chmod 644
#	find ${D}/usr/share/common-lisp/source/cmucl-clx -type d -print0 | xargs -0 chmod 755
	dosym /usr/share/common-lisp/source/cmucl-clx/cmucl-clx.asd \
		/usr/share/common-lisp/systems/

	keepdir /usr/lib/common-lisp/cmucl
	impl-save-timestamp-hack cmucl || die
}

pkg_postinst() {
	standard-impl-postinst cmucl
	register-common-lisp-source cmucl-graystream
	register-common-lisp-source cmucl-clx
}

pkg_prerm() {
	standard-impl-postrm cmucl /usr/bin/lisp
	unregister-common-lisp-source cmucl-graystream
	unregister-common-lisp-source cmucl-clx
}

pkg_postrm() {
	if [ ! -x /usr/bin/lisp ]; then
		rm -rf /usr/lib/cmucl/ || die
	fi
}
