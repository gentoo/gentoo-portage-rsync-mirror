# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/execjs/execjs-2.0.0.ebuild,v 1.1 2013/08/23 06:17:00 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

GITHUB_USER="sstephenson"
GITHUB_PROJECT="${PN}"

inherit ruby-fakegem

DESCRIPTION="ExecJS lets you run JavaScript code from Ruby"
HOMEPAGE="https://github.com/sstephenson/execjs"
SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_PROJECT}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"

IUSE="test"

# execjs supports various javascript runtimes. They are listed in order
# as per the documentation. For now only include the ones already in the
# tree.

# therubyracer, therubyrhino, node.js

RDEPEND="${RDEPEND} || ( net-libs/nodejs )"
