# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/predict/predict-2.2.3.ebuild,v 1.7 2011/03/02 13:24:08 jlec Exp $

EAPI="1"

inherit toolchain-funcs eutils

DESCRIPTION="Satellite tracking and orbital prediction"
HOMEPAGE="http://www.qsl.net/kd2bd/predict.html"
SRC_URI="http://www.amsat.org/amsat/ftp/software/Linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc gtk nls xforms xplanet"
KEYWORDS="amd64 ~ppc x86"

DEPEND="
	sys-libs/ncurses
	gtk? ( x11-libs/gtk+:1 )
	xforms? ( x11-libs/xforms )
	xplanet? ( || ( x11-misc/xplanet x11-misc/xearth ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-xforms.patch
	# fix for buffer overflow (Bug #339109)
	sed -i -e "s/netport\[6\]/netport\[7\]/g" predict.c || die
	# fix some further array out of bounds errors
	sed -i -e "s/satname\[ 26/satname\[ 25/g" \
		clients/gsat-1.1.0/src/db.c || die
	sed -i -e "s/satname\[ 26/satname\[ 25/g" \
		clients/gsat-1.1.0/src/comms.c || die
}

src_compile() {
	# predict uses a ncurses based configure script
	# this is what it does if it was bash based ;)
	COMPILER="$(tc-getCC) ${CFLAGS} ${LDFLAGS}"

	einfo "Compiling predict"
	echo "char *predictpath=\"/usr/share/predict/\";" > predict.h
	echo "char soundcard=1;" >> predict.h
	echo "char *version=\"${PV}\";" >> predict.h
	${COMPILER} \
		predict.c -o predict \
		-L/$(get_libdir) -lm -lncurses -lpthread \
		|| die "Failed compiling predict"

	einfo "Compiling vocalizer"
	cd vocalizer
	echo "char *path={\"/usr/share/predict/vocalizer/\"};" > vocalizer.h
	${COMPILER} vocalizer.c -o vocalizer \
		|| die "Failed compiling vocalizer"

	if use xplanet; then
		einfo "Compiling earthtrack"
		cd "${S}"/clients/earthtrack
		# fix include path
		sed -i \
			-e "s:/usr/local/share/xplanet:/usr/share/xplanet:" \
			earthtrack.c || die "Failed to fix xplanet paths"
		${COMPILER} earthtrack.c -o earthtrack  -lm \
			|| die "Failed compiling earthtrack"
	fi

	# kep_reload
	einfo "Compiling kep_reload"
	cd "${S}"/clients/kep_reload
	${COMPILER} kep_reload.c -o kep_reload || \
		die "Failed compiling kep_reload"

	# map
	if use xforms; then
		einfo "Compiling map"
		cd "${S}"/clients/map
		${COMPILER} -I/usr/X11R6/include \
			map.c map_cb.c map_main.c \
			-L/usr/X11R6/$(get_libdir) -lforms -lX11 -lm \
			-o map || die "Failed compiling map"
	fi

	# gsat
	if use gtk; then
		# note there are plugins for gsat but they are missing
		## header files and wont compile
		einfo "Compiling gsat"
		cd "${S}"/clients/gsat-*
		econf $(use_enable nls)
		cd src
		sed -i \
			-e "s:#define DEFAULTPLUGINSDIR .*:#define DEFAULTPLUGINSDIR \"/usr/$(get_libdir)/gsat/plugins/\":" \
			-e 's:int errno;::' \
			globals.h || die
		cd ..
		emake || die "Failed compiling gsat"
	fi
}

src_install() {
	dobin predict "${FILESDIR}"/predict-update || die
	dodoc CHANGES CREDITS HISTORY README NEWS
	doman docs/man/predict.1
	insinto /usr/share/${PN}/default
	doins default/predict.* || die
	if use doc; then
		dodoc docs/postscript/predict.ps || die
		insinto /usr/share/doc/${PF}
		doins docs/pdf/predict.pdf || die
	fi

	exeinto /usr/bin
	cd vocalizer
	doexe vocalizer || die
	dosym  /usr/bin/vocalizer /usr/share/predict/vocalizer/vocalizer
	insinto /usr/share/${PN}/vocalizer
	doins *.wav || die "Failed to install vocalizer *.wav files"

	# earthtrack
	if use xplanet; then
		cd "${S}"/clients/earthtrack
		ln -s earthtrack earthtrack2
		dobin earthtrack earthtrack2 || die
		newdoc README README.earthtrack
	fi

	# kep_reload
	cd "${S}"/clients/kep_reload
	dobin kep_reload
	newdoc README README.kep_reload

	# map
	if use xforms; then
		cd "${S}"/clients/map
		dobin map || die
		newdoc CHANGES CHANGES.map
		newdoc README README.map
	fi

	# gsat
	if use gtk; then
		# the install seems broken so do manually...
		cd "${S}"/clients/gsat-*
		dodir /usr/$(get_libdir)/gsat/plugins
		keepdir /usr/$(get_libdir)/gsat/plugins
		cd src
		dobin gsat
		cd ..
		for i in AUTHORS ABOUT-NLS ChangeLog NEWS README Plugin_API; do
			newdoc ${i} ${i}.gsat
		done
	fi
}

pkg_postinst() {
	einfo "To use the clients the following line will"
	einfo "have to be inserted into /etc/services"
	einfo "predict    1210/udp"
	einfo "The port can be changed to anything"
	einfo "the name predict is what is needed to work"
	einfo "after that is set run 'predict -s'"
	einfo ""
	einfo "To get list of satellites run 'predict-update'"
	einfo "before running predict this script will also update"
	einfo "the list of satellites so they are up to date."
}
