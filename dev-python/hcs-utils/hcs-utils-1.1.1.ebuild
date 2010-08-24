# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
inherit distutils

DESCRIPTION="A library containing some useful snippets"
HOMEPAGE="http://pypi.python.org/pypi/hcs_utils"
SRC_URI="mirror://pypi/h/${PN/-/_}/${P/-/_}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${P/-/_}"