# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ttfunk/ttfunk-1.0.3-r1.ebuild,v 1.1 2013/10/30 03:43:21 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem versionator

DESCRIPTION="A TrueType font parser written in pure ruby."
HOMEPAGE="https://github.com/sandal/ttfunk/"

LICENSE="|| ( GPL-2 GPL-3 Ruby )"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64"
IUSE=""
