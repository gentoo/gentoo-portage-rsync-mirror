# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtdemo/qtdemo-4.8.4.ebuild,v 1.1 2013/03/02 15:27:09 yngwin Exp $

EAPI=4

inherit qt4-build

DESCRIPTION="Demonstration module and examples for the Qt toolkit"
SLOT="4"
if [[ ${QT4_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="amd64 ppc ppc64 x86 ~x64-macos"
fi
IUSE="dbus declarative kde multimedia opengl openvg qt3support webkit xmlpatterns"

DEPEND="
	~dev-qt/qthelp-${PV}:4[aqua=,debug=]
	~dev-qt/qtcore-${PV}:4[aqua=,debug=,qt3support?]
	~dev-qt/qtgui-${PV}:4[aqua=,debug=,qt3support?]
	~dev-qt/qtscript-${PV}:4[aqua=,debug=]
	~dev-qt/qtsql-${PV}:4[aqua=,debug=,qt3support?]
	~dev-qt/qtsvg-${PV}:4[aqua=,debug=]
	~dev-qt/qttest-${PV}:4[aqua=,debug=]
	dbus? ( ~dev-qt/qtdbus-${PV}:4[aqua=,debug=] )
	declarative? ( ~dev-qt/qtdeclarative-${PV}:4[aqua=,debug=,webkit?] )
	kde? ( media-libs/phonon[aqua=] )
	!kde? ( || (
		~dev-qt/qtphonon-${PV}:4[aqua=,debug=]
		media-libs/phonon[aqua=]
	) )
	multimedia? ( ~dev-qt/qtmultimedia-${PV}:4[aqua=,debug=] )
	opengl? ( ~dev-qt/qtopengl-${PV}:4[aqua=,debug=,qt3support?] )
	openvg? ( ~dev-qt/qtopenvg-${PV}:4[aqua=,debug=,qt3support?] )
	qt3support? ( ~dev-qt/qt3support-${PV}:4[aqua=,debug=] )
	webkit? ( ~dev-qt/qtwebkit-${PV}:4[aqua=,debug=] )
	xmlpatterns? ( ~dev-qt/qtxmlpatterns-${PV}:4[aqua=,debug=] )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-4.6-plugandpaint.patch"
)

pkg_setup() {
	QT4_TARGET_DIRECTORIES="
		demos
		examples"
	QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
		doc/src/images
		src
		include
		tools"

	qt4-build_pkg_setup
}

src_prepare() {
	qt4-build_src_prepare

	# Array mapping USE flags to subdirs
	local flags_subdirs_map=(
		'dbus'
		'declarative:declarative'
		'multimedia:spectrum'
		'opengl:boxes|glhypnotizer'
		'openvg'
		'webkit:browser'
		'xmlpatterns'
	)

	# Disable unwanted examples/demos
	for flag in "${flags_subdirs_map[@]}"; do
		if ! use ${flag%:*}; then
			einfo "Disabling ${flag%:*} examples"
			sed -i -e "/SUBDIRS += ${flag%:*}/d" \
				examples/examples.pro || die

			if [[ ${flag} == *:* ]]; then
				einfo "Disabling ${flag%:*} demos"
				sed -i -re "/SUBDIRS \+= demos_(${flag#*:})/d" \
					demos/demos.pro || die
			fi
		fi
	done

	if ! use qt3support; then
		einfo "Disabling qt3support examples"
		sed -i -e '/QT_CONFIG, qt3support/d' \
			examples/graphicsview/graphicsview.pro || die
	fi
}

src_configure() {
	myconf+="
		$(qt_use dbus)
		$(qt_use declarative)
		$(qt_use multimedia)
		$(qt_use opengl)
		$(qt_use openvg)
		$(qt_use qt3support)
		$(qt_use webkit)
		$(qt_use xmlpatterns)"

	qt4-build_src_configure
}

src_install() {
	insinto "${QTDOCDIR#${EPREFIX}}"/src
	doins -r doc/src/images

	qt4-build_src_install
}
