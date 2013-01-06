# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amatch/amatch-0.2.5.ebuild,v 1.6 2012/05/01 18:24:06 armin76 Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES README"

inherit ruby-fakegem

DESCRIPTION="A template library for ruby like amrita"
HOMEPAGE="http://flori.github.com/amatch/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ppc64 x86"
IUSE=""
